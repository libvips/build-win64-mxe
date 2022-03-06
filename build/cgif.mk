PKG             := cgif
$(PKG)_WEBSITE  := https://github.com/dloebl/cgif
$(PKG)_DESCR    := A fast and lightweight GIF encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.2.1
$(PKG)_CHECKSUM := ffe60dc57c333ef891c862ed52ff12e7461c28955c5203ecbedf526fc75d3124
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
