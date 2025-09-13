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

# GTK requires a relocatable GDK-PixBuf plugin with SVG support.
# TODO(kleisauke): Probably no longer needed in GTK >= 4.19.2.
gdk-pixbuf_PATCHES := $(filter-out $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/gdk-pixbuf-2-without-relocation.patch))),$(gdk-pixbuf_PATCHES))
librsvg_DEPS := $(librsvg_DEPS) gdk-pixbuf
librsvg_MESON_OPTS = -Dpixbuf=enabled -Dpixbuf-loader=enabled

# nip4 needs -Doutput=enabled
libxml2_MESON_OPTS := $(libxml2_MESON_OPTS) -Doutput=enabled

# Override sub-dependencies
adwaita-icon-theme_DEPS := $(subst gtk3,gtk4,$(adwaita-icon-theme_DEPS))
libepoxy_DEPS := $(filter-out  xorg-macros,$(libepoxy_DEPS))
