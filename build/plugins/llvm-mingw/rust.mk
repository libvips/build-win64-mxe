PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/2024-03-14/rustc-nightly-src.tar.xz.sha256
$(PKG)_VERSION  := nightly
$(PKG)_CHECKSUM := 0d70617e70a3f13f5d932c61ade9669d5016f4ae760b400c247c74bce9c0e4b3
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)c-$($(PKG)_VERSION)-src
$(PKG)_FILE     := $(PKG)c-$($(PKG)_VERSION)-src.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/2024-03-14/$($(PKG)_FILE)
$(PKG)_DEPS     := $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) := $(BUILD)~llvm

# Build Rust from source to support the ARM targets and
# to ensure that it links against UCRT (the prebuilt Rust
# binaries are built with --with-default-msvcrt=msvcrt)
define $(PKG)_BUILD_$(BUILD)
    # x86_64-pc-linux-gnu -> x86_64-unknown-linux-gnu
    $(eval BUILD_RUST := $(firstword $(subst -, ,$(BUILD)))-unknown-linux-gnu)

    # Disable LTO, panic strategy and optimization settings while
    # we bootstrap Rust
    $(eval unexport CARGO_PROFILE_RELEASE_LTO)
    $(eval unexport CARGO_PROFILE_RELEASE_OPT_LEVEL)
    $(eval unexport CARGO_PROFILE_RELEASE_PANIC)

    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    # ld.lld: error: librsvg_c_api.a(bcryptprimitives.dll): .idata$4 should not refer to special section 0
    (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < \
        '$(SOURCE_DIR)/compiler/rustc_codegen_cranelift/patches/0029-stdlib-rawdylib-processprng.patch'

    # TODO(kleisauke): Build with --enable-vendor if we are no longer
    # patching panic_unwind/unwind.
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        --prefix='$(PREFIX)/$(BUILD)' \
        --sysconfdir='etc' \
        --release-channel=nightly \
        --enable-extended \
        --tools=cargo,src \
        --disable-docs \
        --disable-codegen-tests \
        --disable-manage-submodules \
        --python='$(PYTHON3)' \
        --llvm-root='$(PREFIX)/$(BUILD)' \
        --set target.$(BUILD_RUST).cc='$(PREFIX)/$(BUILD)/bin/clang' \
        --set target.$(BUILD_RUST).cxx='$(PREFIX)/$(BUILD)/bin/clang++' \
        --set target.$(BUILD_RUST).linker='$(PREFIX)/$(BUILD)/bin/clang' \
        --set target.$(BUILD_RUST).ar='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        --set target.$(BUILD_RUST).ranlib='$(PREFIX)/$(BUILD)/bin/llvm-ranlib'

    # Enable networking while we build Rust from source. Assumes
    # that the Rust build is reproducible.
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Ensure that the downloaded build dependencies of Cargo are
    # stored in the build directory.
    $(eval export CARGO_HOME := $(BUILD_DIR)/.cargo)

    # Build and install Rust
    # Note: we are only interested in the stage1 compiler
    cd '$(BUILD_DIR)' && \
        $(PYTHON3) $(SOURCE_DIR)/x.py install --stage 1 -j '$(JOBS)' -v

    # Copy the Cargo.lock for Rust to places `vendor` will see
    # https://github.com/rust-lang/wg-cargo-std-aware/issues/23#issuecomment-720455524
    # https://github.com/rust-lang/cargo/pull/12088
    cp '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/Cargo.lock' '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/library/sysroot'

    # `c` feature of the `compiler-builtins` crate needs the
    # compiler-rt sources from LLVM
    $(call PREPARE_PKG_SOURCE,llvm,$(BUILD_DIR))
    rm -rf '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/src/llvm-project/compiler-rt'
    mv '$(BUILD_DIR)/$(llvm_SUBDIR)/compiler-rt' '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/src/llvm-project'
endef

define $(PKG)_BUILD
    $(eval TARGET_RUST := $(PROCESSOR)-pc-windows-gnullvm)

    # Build and prepare startup objects like rsbegin.o and rsend.o
    $(foreach FILE, rsbegin rsend, \
        $(PREFIX)/$(BUILD)/bin/rustc -Ainternal_features --target='$(TARGET_RUST)' --emit=obj -o '$(BUILD_DIR)/$(FILE).o' \
            '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/library/rtstartup/$(FILE).rs';)

    # Install the startup objects
    $(INSTALL) -d '$(PREFIX)/$(BUILD)/lib/rustlib/$(TARGET_RUST)/lib'
    mv -vf '$(BUILD_DIR)/'rs{begin,end}.o '$(PREFIX)/$(BUILD)/lib/rustlib/$(TARGET_RUST)/lib'

    # Install Cargo config
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/.cargo'
    (echo '[unstable]'; \
     echo 'build-std = ["std", "panic_abort"]'; \
     echo 'build-std-features = ["panic_immediate_abort", "compiler-builtins-c", "compiler-builtins-weak-intrinsics"]'; \
     echo '[build]'; \
     echo 'target = "$(TARGET_RUST)"'; \
     echo '[env]'; \
     echo 'CC_$(TARGET_RUST) = "$(TARGET)-clang"'; \
     echo 'RUST_COMPILER_RT_ROOT = "$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/src/llvm-project/compiler-rt"'; \
     echo '[target.$(TARGET_RUST)]'; \
     echo 'linker = "$(TARGET)-clang"'; \
     echo 'ar = "$(PREFIX)/$(BUILD)/bin/llvm-ar"';) \
             > '$(PREFIX)/$(TARGET)/.cargo/config.toml'

    # Install prefixed wrappers
    (echo '#!/usr/bin/env bash'; \
     echo 'CARGO_HOME="$(PREFIX)/$(TARGET)/.cargo" \'; \
     echo 'RUSTC="$(PREFIX)/$(BUILD)/bin/rustc" \'; \
     echo 'exec $(PREFIX)/$(BUILD)/bin/cargo \'; \
     echo '"$$@"';) \
             > '$(PREFIX)/bin/$(TARGET)-cargo'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-cargo'

    ln -sf '$(PREFIX)/$(BUILD)/bin/rustc' '$(PREFIX)/bin/$(TARGET)-rustc'
endef
