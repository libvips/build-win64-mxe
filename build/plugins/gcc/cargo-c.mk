PKG             := cargo-c
$(PKG)_WEBSITE  := https://github.com/lu-zero/cargo-c
$(PKG)_DESCR    := cargo applet to build and install C-ABI compatibile libraries
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.7.3
$(PKG)_CHECKSUM := 533c65d555330e86b91415753efc140ffdb900abd59b5b6403352c4264941a99
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lu-zero/cargo-c/tags,v
$(PKG)_DEPS     := rust

define $(PKG)_BUILD
    # Enable networking while we build cargo-c
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Disable LTO, panic strategy and optimization settings while
    # we build cargo-c
    $(eval unexport CARGO_PROFILE_RELEASE_LTO)
    $(eval unexport CARGO_PROFILE_RELEASE_OPT_LEVEL)
    $(eval unexport CARGO_PROFILE_RELEASE_PANIC)

    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    # Install in $(PREFIX)/$(TARGET) to avoid conflicts 
    # with the llvm-mingw plugin.
    # TODO(kleisauke): Could be installed in $(PREFIX)/$(BUILD)
    # if we build all binaries with LLVM.
    cd '$(SOURCE_DIR)' && CC='$(BUILD_CC)' $(TARGET)-cargo build \
        --release \
        --target='x86_64-unknown-linux-gnu' \
        --features=vendored-openssl

    CC='$(BUILD_CC)' $(TARGET)-cargo install \
        --path='$(SOURCE_DIR)' \
        --target='x86_64-unknown-linux-gnu' \
        --features=vendored-openssl
endef
