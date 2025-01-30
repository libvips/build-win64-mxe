# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    $(eval RUST_SYSROOT := $(shell RUSTUP_HOME=/usr/local/rustup rustc --print sysroot))
    $(eval TARGET_RUST := $(PROCESSOR)-pc-windows-gnullvm)

    # FIXME: Enable the compiler-builtins-c build-std feature.
    # Install Cargo config
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/.cargo'
    (echo '[unstable]'; \
     echo 'build-std = ["std", "panic_abort"]'; \
     echo 'build-std-features = ["panic_immediate_abort"]'; \
     echo '[build]'; \
     echo 'target = "$(TARGET_RUST)"'; \
     echo '[env]'; \
     echo 'CC_$(TARGET_RUST) = "$(TARGET)-clang"'; \
     echo 'RUST_COMPILER_RT_ROOT = "$(RUST_SYSROOT)/lib/rustlib/src/rust/src/llvm-project/compiler-rt"'; \
     echo '[target.$(TARGET_RUST)]'; \
     echo 'ar = "$(PREFIX)/$(BUILD)/bin/llvm-ar"'; \
     echo 'linker = "$(TARGET)-clang"'; \
     $(if $(BUILD_STATIC), echo 'rustflags = ["-Ctarget-feature=+crt-static"]';)) \
             > '$(PREFIX)/$(TARGET)/.cargo/config.toml'
endef
