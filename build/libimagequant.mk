PKG             := libimagequant
$(PKG)_WEBSITE  := https://github.com/lovell/libimagequant
$(PKG)_DESCR    := libimagequant v2.4.1 fork (BSD 2-Clause)
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.1
$(PKG)_CHECKSUM := 47d2a84b7b1052975c9d50a3d4e3cacbf57b43d84a4c3131210848ead9964dfb
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := lovell/libimagequant/tags,v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
