PKG             := cargo-c
$(PKG)_WEBSITE  := https://github.com/lu-zero/cargo-c
$(PKG)_DESCR    := cargo applet to build and install C-ABI compatibile libraries
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.9.32
$(PKG)_CHECKSUM := a96f3cc6c63d9901c9583083338d50b0132504bb067f68accc17f4116ed01f72
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lu-zero/cargo-c/tags,v
$(PKG)_TARGETS  := $(BUILD)
$(PKG)_DEPS_$(BUILD) := $(BUILD)~rust

define $(PKG)_BUILD_$(BUILD)
    # Enable networking while we build cargo-c
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Ensure that the downloaded build dependencies of Cargo are
    # stored in the build directory.
    $(eval export CARGO_HOME := $(BUILD_DIR)/.cargo)

    # Disable LTO, panic strategy and optimization settings while
    # we build cargo-c
    $(eval unexport CARGO_PROFILE_RELEASE_LTO)
    $(eval unexport CARGO_PROFILE_RELEASE_OPT_LEVEL)
    $(eval unexport CARGO_PROFILE_RELEASE_PANIC)

    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    cd '$(SOURCE_DIR)' && cargo build \
        --release

    cargo install \
        --path='$(SOURCE_DIR)' \
        --root='$(PREFIX)/$(BUILD)'
endef
