PKG             := rav1e
$(PKG)_WEBSITE  := https://github.com/xiph/rav1e
$(PKG)_DESCR    := The fastest and safest AV1 encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.7.1
$(PKG)_CHECKSUM := da7ae0df2b608e539de5d443c096e109442cdfa6c5e9b4014361211cf61d030c
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := xiph/rav1e/tags,v
$(PKG)_DEPS     := cc rust $(BUILD)~nasm $(BUILD)~cargo-c

define $(PKG)_BUILD
    $(eval export CARGO_HOME := $(PREFIX)/$(TARGET)/.cargo)

    # Enable networking while we build rav1e
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Uncomment to build/install rav1e binary
    #cargo install --no-track --path='$(SOURCE_DIR)' --root='$(PREFIX)/$(TARGET)'
    cd '$(SOURCE_DIR)' && cargo cinstall \
        --release \
        --meson-paths \
        --no-default-features \
        --features=asm,threading \
        --prefix='$(PREFIX)/$(TARGET)' \
        --target='$(PROCESSOR)-pc-windows-gnullvm' \
        --target-dir='$(BUILD_DIR)' \
        --library-type=$(if $(BUILD_STATIC),staticlib,cdylib)
endef
