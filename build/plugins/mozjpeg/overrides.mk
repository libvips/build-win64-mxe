$(PLUGIN_HEADER)

IS_MOZJPEG := $(true)

# Override sub-dependencies
gdk-pixbuf_DEPS  := $(subst libjpeg-turbo,mozjpeg,$(gdk-pixbuf_DEPS))
imagemagick_DEPS := $(subst libjpeg-turbo,mozjpeg,$(imagemagick_DEPS))
libjxl_DEPS      := $(subst libjpeg-turbo,mozjpeg,$(libjxl_DEPS))
openslide_DEPS   := $(subst libjpeg-turbo,mozjpeg,$(openslide_DEPS))
poppler_DEPS     := $(subst libjpeg-turbo,mozjpeg,$(poppler_DEPS))
tiff_DEPS        := $(subst libjpeg-turbo,mozjpeg,$(tiff_DEPS))
vips-all_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-all_DEPS))
vips-web_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-web_DEPS))

# Disable the libjpeg-turbo build, just to be sure
libjpeg-turbo_BUILD_x86_64-w64-mingw32  =
libjpeg-turbo_BUILD_i686-w64-mingw32    =
libjpeg-turbo_BUILD_aarch64-w64-mingw32 =
libjpeg-turbo_BUILD_armv7-w64-mingw32   =
