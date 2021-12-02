PKG             := cgif
$(PKG)_WEBSITE  := https://github.com/dloebl/cgif
$(PKG)_DESCR    := A fast and lightweight GIF encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.0.3
$(PKG)_CHECKSUM := 160e88bc126ad0f1fa6ae07b7660852242efefe687bc0181e3b5acea01939bd4
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_GH_CONF  := dloebl/cgif/tags,V
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        -Dtests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
