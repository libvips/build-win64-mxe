PKG             := cgif
$(PKG)_WEBSITE  := https://github.com/dloebl/cgif
$(PKG)_DESCR    := A fast and lightweight GIF encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.0.2
$(PKG)_CHECKSUM := 679e8012b9fe387086e6b3bcc42373dbc66fb26f8d070d7a1d23f39d42842258
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
