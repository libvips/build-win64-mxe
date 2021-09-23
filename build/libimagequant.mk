PKG             := libimagequant
$(PKG)_WEBSITE  := https://github.com/lovell/libimagequant
$(PKG)_DESCR    := libimagequant v2.4.1 fork (BSD 2-Clause)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.1
$(PKG)_CHECKSUM := 9a808f7dde0b3b9a51632ec903b8a36f4342b95e66496c0919b3619cf03e022f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lovell/libimagequant/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-meson' '$(SOURCE_DIR)' '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
