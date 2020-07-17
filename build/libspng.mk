PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.0
$(PKG)_CHECKSUM := 81fea8d8a2e0c8aa51769605ad0e49a682e88697c6b5b60105f5c3806efaa3a3
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := randy408/libspng/tags,v
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --includedir='include' \
        -Dstatic_zlib=$(if $(BUILD_STATIC),true,false) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
