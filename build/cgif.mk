PKG             := cgif
$(PKG)_WEBSITE  := https://github.com/dloebl/cgif
$(PKG)_DESCR    := A fast and lightweight GIF encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.1
$(PKG)_CHECKSUM := 8666f9c5f8123d1c22137a6dd714502a330377fb74e2007621926fe4258529d5
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_GH_CONF  := dloebl/cgif/tags,v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)

    $(MXE_MESON_WRAPPER) \
        -Dtests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
