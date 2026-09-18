$(PLUGIN_HEADER)

# GTK requires GRegex
glib_PATCHES := $(filter-out $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/glib-2-without-gregex.patch))),$(glib_PATCHES))
glib_MESON_OPTS = --force-fallback-for=libpcre2-8

# GTK requires cairo-win32, cairo-ps and cairo-pdf
# https://gitlab.gnome.org/GNOME/gtk/-/issues/5072
# Also enable the DWrite font backend in Cairo
# https://gitlab.gnome.org/GNOME/gtk/-/issues/7144
cairo_PATCHES := $(filter-out $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/cairo-1-nanoserver-compat.patch))),$(cairo_PATCHES))
cairo_MESON_OPTS = -Dzlib=enabled -Ddwrite=enabled

# GTK requires harfbuzz-subset
harfbuzz_DEPS := $(harfbuzz_DEPS) libpng
harfbuzz_MESON_OPTS = -Dsubset=enabled

# nip4 needs -Doutput=enabled
libxml2_MESON_OPTS := $(libxml2_MESON_OPTS) -Doutput=enabled

# nip4 needs IM with TIFF support
imagemagick_DEPS := $(imagemagick_DEPS) tiff
imagemagick_CONFIGURE_OPTS = --with-tiff

## Update dependencies

# upstream version is 1.10.8
# build from the master branch for https://github.com/ebassi/graphene/commit/1a4430f448e0fcc8188cfe9323f1a688d0486eae
# https://github.com/ebassi/graphene/tarball/98173e59a3d80d3dd5ad6e4eaab919b4649ac7e5
graphene_VERSION  := 98173e5
graphene_CHECKSUM := 2b122352dda3f68d5d561a9b628bc9ac6c0ccc7af044e6c8fa9fdd496f98def2
graphene_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/graphene-[0-9]*.patch)))
graphene_GH_CONF  := ebassi/graphene/branches/master

# upstream version is 4.18.6
gtk4_VERSION  := 4.24.0
gtk4_CHECKSUM := 28ba4ac1c04f86eac09b79a163cb163a4c2b54442d9f7eccc04679062a581044
gtk4_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gtk-[0-9]*.patch)))
gtk4_SUBDIR   := gtk-$(gtk4_VERSION)
gtk4_FILE     := gtk-$(gtk4_VERSION).tar.xz
gtk4_URL      := https://download.gnome.org/sources/gtk/$(call SHORT_PKG_VERSION,gtk4)/$(gtk4_FILE)

# upstream version is 1.6.58
# build from the libpng18 branch for APNG support
# https://github.com/pnggroup/libpng/tarball/964b4135949703b705fc760fc3fb546b86e5ab47
libpng_VERSION  := 964b413
libpng_CHECKSUM := b7a21695e49b6aa23240add6eead18381a01d3bc31fc2a07d1dd8e6059c691cc
libpng_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libpng-[0-9]*.patch)))
libpng_SUBDIR   := pnggroup-libpng-$(libpng_VERSION)
libpng_FILE     := pnggroup-libpng-$(libpng_VERSION).tar.gz
libpng_URL      := https://github.com/pnggroup/libpng/tarball/$(libpng_VERSION)/$(libpng_FILE)

## Override sub-dependencies
# adwaita-icon-theme:
#  Replaced: gtk3 with gtk4
# gtk4:
#  Added: cc, directx-headers
#  Removed: libiconv, gettext, gst-plugins-bad, lzo
# libepoxy:
#  Removed: xorg-macros

adwaita-icon-theme_DEPS := $(subst gtk3,gtk4,$(adwaita-icon-theme_DEPS))
gtk4_DEPS               := cc meson-wrapper glib gdk-pixbuf pango fontconfig cairo libepoxy graphene directx-headers
libepoxy_DEPS           := $(filter-out  xorg-macros,$(libepoxy_DEPS))

## Override build scripts

# disable introspection
# build without `-Dgcc_vector=false` and `-Dsse2=false`
define graphene_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dintrospection=disabled \
        -Dtests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# disable tools and gstreamer
define gtk4_BUILD
    # Disable tools
    $(SED) -i "/subdir('tools')/d" '$(SOURCE_DIR)/meson.build'

    $(MXE_MESON_WRAPPER) \
        -Dvulkan=disabled \
        -Dintrospection=disabled \
        -Dmedia-gstreamer=disabled \
        -Dbuild-testsuite=false \
        -Dbuild-examples=false \
        -Dbuild-tests=false \
        -Dbuild-demos=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# autoreconf as we're building from Git sources
define libpng_BUILD
    # need to generate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(INSTALL_STRIP_LIB) bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=

    ln -sf '$(PREFIX)/$(TARGET)/bin/libpng-config' '$(PREFIX)/bin/$(TARGET)-libpng-config'
endef
