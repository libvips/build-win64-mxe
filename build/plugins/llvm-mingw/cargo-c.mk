PKG             := cargo-c
$(PKG)_WEBSITE  := https://github.com/lu-zero/cargo-c
$(PKG)_DESCR    := cargo applet to build and install C-ABI compatibile libraries
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.9.1
$(PKG)_CHECKSUM := ae79b9a6e862f103a71db044a0713d9dad753000913c751b124a11c19cb3a94c
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lu-zero/cargo-c/tags,v
$(PKG)_DEPS     := $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) := $(BUILD)~rust

define $(PKG)_BUILD_$(BUILD)
    # Enable networking while we build cargo-c
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Disable LTO, panic strategy and optimization settings while
    # we build cargo-c
    $(eval unexport CARGO_PROFILE_RELEASE_LTO)
    $(eval unexport CARGO_PROFILE_RELEASE_OPT_LEVEL)
    $(eval unexport CARGO_PROFILE_RELEASE_PANIC)

    cd '$(SOURCE_DIR)' && $(PREFIX)/$(BUILD)/bin/cargo build \
        --release \
        --features=vendored-openssl

    $(PREFIX)/$(BUILD)/bin/cargo install \
        --path='$(SOURCE_DIR)' \
        --root='$(PREFIX)/$(BUILD)/.cargo' \
        --features=vendored-openssl
endef

define $(PKG)_BUILD
    # setup symlinks
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/.cargo/bin'
    $(foreach EXEC, capi cbuild cinstall ctest, \
        ln -sf '$(PREFIX)/$(BUILD)/.cargo/bin/cargo-$(EXEC)' '$(PREFIX)/$(TARGET)/.cargo/bin/cargo-$(EXEC)';)
endef
