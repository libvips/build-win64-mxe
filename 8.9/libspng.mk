PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
# https://github.com/randy408/libspng/tarball/5ee9bdf5b99e3388904fee37cd8ca662e05555aa
$(PKG)_VERSION  := 5ee9bdf
$(PKG)_CHECKSUM := cd2fd84628cf2207a4fb1319f7ca39c0785ab37adff843a62a89f75cd67eb851
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
