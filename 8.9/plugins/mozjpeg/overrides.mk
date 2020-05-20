$(PLUGIN_HEADER)

# Override libjpeg-turbo version for the versions.json file
# TODO: Wait for https://github.com/mozilla/mozjpeg/issues/321
libjpeg-turbo_VERSION := 4.0.0-git

# Override sub-dependencies
gdk-pixbuf_DEPS  := $(subst libjpeg-turbo,mozjpeg,$(gdk-pixbuf_DEPS))
tiff_DEPS        := $(subst libjpeg-turbo,mozjpeg,$(tiff_DEPS))
imagemagick_DEPS := $(subst libjpeg-turbo,mozjpeg,$(imagemagick_DEPS))
poppler_DEPS     := $(subst libjpeg-turbo,mozjpeg,$(poppler_DEPS))
openslide_DEPS   := $(subst libjpeg-turbo,mozjpeg,$(openslide_DEPS))
vips-web_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-web_DEPS))
vips-all_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-all_DEPS))

# Disable the libjpeg-turbo build, just to be sure
libjpeg-turbo_BUILD_x86_64-w64-mingw32  =
libjpeg-turbo_BUILD_i686-w64-mingw32    =
libjpeg-turbo_BUILD_aarch64-w64-mingw32 =
libjpeg-turbo_BUILD_armv7-w64-mingw32   =
