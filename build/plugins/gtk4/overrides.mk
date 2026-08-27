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
gtk4_VERSION  := 4.23.3
gtk4_CHECKSUM := c81912b082a5beaad1d84944805bf7cc0f86c6a933e131664dad3db326ede924
gtk4_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gtk-[0-9]*.patch)))
gtk4_SUBDIR   := gtk-$(gtk4_VERSION)
gtk4_FILE     := gtk-$(gtk4_VERSION).tar.xz
gtk4_URL      := https://download.gnome.org/sources/gtk/$(call SHORT_PKG_VERSION,gtk4)/$(gtk4_FILE)

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
