PKG             := rav1e
$(PKG)_WEBSITE  := https://github.com/xiph/rav1e
$(PKG)_DESCR    := The fastest and safest AV1 encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.8.1
$(PKG)_CHECKSUM := 06d1523955fb6ed9cf9992eace772121067cca7e8926988a1ee16492febbe01e
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := xiph/rav1e/tags,v
$(PKG)_DEPS     := cc rust $(BUILD)~nasm $(BUILD)~cargo-c

define $(PKG)_PREPARE
    $(eval export CARGO_HOME := $(PREFIX)/$(TARGET)/.cargo)

    cd '$(SOURCE_DIR)' && MXE_ENABLE_NETWORK=1 cargo fetch --locked
endef

define $(PKG)_BUILD
    $($(PKG)_PREPARE)

    # Uncomment to build/install rav1e binary
    #cargo install \
    #    --frozen \
    #    --no-track \
    #    --path='$(SOURCE_DIR)' \
    #    --root='$(PREFIX)/$(TARGET)'

    cd '$(SOURCE_DIR)' && cargo cinstall \
        --release \
        --frozen \
        --meson-paths \
        --no-default-features \
        --features=asm,threading \
        --prefix='$(PREFIX)/$(TARGET)' \
        --target='$(PROCESSOR)-pc-windows-gnullvm' \
        --target-dir='$(BUILD_DIR)' \
        --library-type=$(if $(BUILD_STATIC),staticlib,cdylib)

    # Remove def file
    rm -fv '$(PREFIX)/$(TARGET)/lib/rav1e.def'
endef
