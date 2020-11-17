PKG             := orc
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/orc.html
$(PKG)_DESCR    := Library and set of tools for compiling and executing SIMD assembly language-like programs that operate on arrays of data.
$(PKG)_IGNORE   :=
$(PKG)_FULL_SHA := 8d32f2d9f4a803e8e27c2f26ab54233d03efd023
$(PKG)_VERSION  := $(call substr,$($(PKG)_FULL_SHA),1,8)
$(PKG)_CHECKSUM := 25e338290db9e1b7ae69a3d8e999d47f315117194ef3cca87c5a34b1a1ad220f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-$($(PKG)_FULL_SHA)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://gitlab.freedesktop.org/api/v4/projects/1360/repository/archive?sha=$($(PKG)_VERSION)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gstreamer.freedesktop.org/src/orc/?C=M;O=D' | \
    $(SED) -n 's,.*orc-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --includedir='include' \
        -Dbenchmarks=disabled \
        -Dexamples=disabled \
        -Dgtk_doc=disabled \
        -Dtests=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
