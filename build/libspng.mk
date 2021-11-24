PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.7.1
$(PKG)_CHECKSUM := 0726a4914ad7155028f3baa94027244d439cd2a2fbe8daf780c2150c4c951d8e
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := randy408/libspng/tags,v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        -Dbuild_examples=false \
        -Dstatic_zlib=$(if $(BUILD_STATIC),true,false) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
