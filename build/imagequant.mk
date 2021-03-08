PKG             := imagequant
$(PKG)_WEBSITE  := https://github.com/lovell/libimagequant
$(PKG)_DESCR    := libimagequant v2.4.1 fork (BSD-2-Clause) with support for building and cross-compiling via meson
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.1
$(PKG)_CHECKSUM := d78a28455598a1b73a4d480c9f1db3048f526971496f4d37a484b71b00624fef
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lovell/libimagequant/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --includedir='include' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
