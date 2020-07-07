PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
# https://github.com/randy408/libspng/tarball/9a08896995b29f195078af3972c85e94d2051468
$(PKG)_VERSION  := 9a08896
$(PKG)_CHECKSUM := 932526e0e30535980d7feb06c75050aca3c99330a264e739154a7d22f8d29565
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := randy408/libspng/branches/master
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
