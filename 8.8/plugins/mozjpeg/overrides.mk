$(PLUGIN_HEADER)

# Override libjpeg-turbo version for the versions.json file
# TODO: Wait for https://github.com/mozilla/mozjpeg/issues/321
libjpeg-turbo_VERSION := 4.0.0-git

# Override sub-dependencies
gdk-pixbuf_DEPS  := $(subst libjpeg-turbo,mozjpeg,$(gdk-pixbuf_DEPS))
imagemagick_DEPS := $(subst libjpeg-turbo,mozjpeg,$(imagemagick_DEPS))
libwebp_DEPS     := $(subst libjpeg-turbo,mozjpeg,$(libwebp_DEPS))
openslide_DEPS   := $(subst libjpeg-turbo,mozjpeg,$(openslide_DEPS))
poppler_DEPS     := $(subst libjpeg-turbo,mozjpeg,$(poppler_DEPS))
tiff_DEPS        := $(subst libjpeg-turbo,mozjpeg,$(tiff_DEPS))
vips-all_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-all_DEPS))
vips-web_DEPS    := $(subst libjpeg-turbo,mozjpeg,$(vips-web_DEPS))
