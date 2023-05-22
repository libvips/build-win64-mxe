PKG             := orc
$(PKG)_WEBSITE  := https://gstreamer.freedesktop.org/modules/orc.html
$(PKG)_DESCR    := Library and set of tools for compiling and executing SIMD assembly language-like programs that operate on arrays of data.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.33
$(PKG)_CHECKSUM := 844e6d7db8086f793f57618d3d4b68d29d99b16034e71430df3c21cfd3c3542a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://gstreamer.freedesktop.org/src/$(PKG)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gstreamer.freedesktop.org/src/orc/?C=M;O=D' | \
    $(SED) -n 's,.*orc-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dorc-test=disabled \
        -Dbenchmarks=disabled \
        -Dexamples=disabled \
        -Dgtk_doc=disabled \
        -Dtests=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
