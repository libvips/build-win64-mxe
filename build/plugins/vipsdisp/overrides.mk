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

# Override sub-dependencies
libepoxy_DEPS := $(filter-out  xorg-macros,$(libepoxy_DEPS))

# upstream version is 1.5.9
libepoxy_VERSION  := 1.5.10
libepoxy_CHECKSUM := 072cda4b59dd098bba8c2363a6247299db1fa89411dc221c8b81b8ee8192e623
libepoxy_FILE     := libepoxy-$(libepoxy_VERSION).tar.xz
libepoxy_URL      := https://download.gnome.org/sources/libepoxy/$(call SHORT_PKG_VERSION,libepoxy)/$(libepoxy_FILE)
