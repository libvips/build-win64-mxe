$(PLUGIN_HEADER)

IS_JPEGLI := $(true)

# Override patches
libjxl_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/libjxl-[0-9]*.patch))) \
                  $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/jpegli-[0-9]*.patch)))

# Override sub-dependencies
gdk-pixbuf_DEPS     := $(subst libjpeg-turbo,jpegli,$(gdk-pixbuf_DEPS))
imagemagick_DEPS    := $(subst libjpeg-turbo,jpegli,$(imagemagick_DEPS))
graphicsmagick_DEPS := $(subst libjpeg-turbo,jpegli,$(graphicsmagick_DEPS))
openslide_DEPS      := $(subst libjpeg-turbo,jpegli,$(openslide_DEPS))
poppler_DEPS        := $(subst libjpeg-turbo,jpegli,$(poppler_DEPS))
tiff_DEPS           := $(subst libjpeg-turbo,jpegli,$(tiff_DEPS))
vips-all_DEPS       := $(subst libjpeg-turbo,jpegli,$(vips-all_DEPS))
vips-web_DEPS       := $(subst libjpeg-turbo,jpegli,$(vips-web_DEPS))

# jpegli needs a couple of headers from libjpeg-turbo
libjxl_DEPS         := $(libjxl_DEPS) libjpeg-turbo

# Make libjpeg-turbo a source-only dependency
libjpeg-turbo_TYPE := source-only
libjpeg-turbo_BUILD_x86_64-w64-mingw32  =
libjpeg-turbo_BUILD_i686-w64-mingw32    =
libjpeg-turbo_BUILD_aarch64-w64-mingw32 =
