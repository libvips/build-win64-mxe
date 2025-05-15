$(PLUGIN_HEADER)

# GTK requires GRegex
glib_PATCHES := $(filter-out $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/glib-2-without-gregex.patch))),$(glib_PATCHES))
glib_CONFIGURE_OPTS = --force-fallback-for=libpcre2-8

# GTK requires cairo-win32, cairo-ps and cairo-pdf
# https://gitlab.gnome.org/GNOME/gtk/-/issues/5072
# Also enable the DWrite font backend in Cairo
# https://gitlab.gnome.org/GNOME/gtk/-/issues/7144
cairo_PATCHES := $(filter-out $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/cairo-1-nanoserver-compat.patch))),$(cairo_PATCHES))
cairo_CONFIGURE_OPTS = -Dzlib=enabled -Ddwrite=enabled

# nip4 needs -Doutput=enabled
libxml2_MESON_OPTS = -Doutput=enabled

# Override sub-dependencies
libepoxy_DEPS := $(filter-out  xorg-macros,$(libepoxy_DEPS))
