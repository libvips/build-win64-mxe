PKG             := libimagequant
$(PKG)_WEBSITE  := https://github.com/lovell/libimagequant
$(PKG)_DESCR    := libimagequant v2.4.1 fork (BSD 2-Clause)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.1
$(PKG)_CHECKSUM := 76dca8e48366d7e16284071528d60c9275c85945e45e887f26ec0028668a144f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lovell/libimagequant/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-meson' '$(SOURCE_DIR)' '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
