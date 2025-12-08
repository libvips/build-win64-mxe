PKG             := cgif
$(PKG)_WEBSITE  := https://github.com/dloebl/cgif
$(PKG)_DESCR    := A fast and lightweight GIF encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.5.0
$(PKG)_CHECKSUM := d6cb312c7da2c6c9f310811aa3658120c0316ba130c48a012e7baf3698920fe9
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := dloebl/cgif/tags,v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)

    $(MXE_MESON_WRAPPER) \
        -Dexamples=false \
        -Dtests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
