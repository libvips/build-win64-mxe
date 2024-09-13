$(PLUGIN_HEADER)

IS_JPEGLI := $(true)

# Override sub-dependencies
gdk-pixbuf_DEPS     := $(subst libjpeg-turbo,jpegli,$(gdk-pixbuf_DEPS))
imagemagick_DEPS    := $(subst libjpeg-turbo,jpegli,$(imagemagick_DEPS))
graphicsmagick_DEPS := $(subst libjpeg-turbo,jpegli,$(graphicsmagick_DEPS))
openslide_DEPS      := $(subst libjpeg-turbo,jpegli,$(openslide_DEPS))
poppler_DEPS        := $(subst libjpeg-turbo,jpegli,$(poppler_DEPS))
tiff_DEPS           := $(subst libjpeg-turbo,jpegli,$(tiff_DEPS))
vips-all_DEPS       := $(subst libjpeg-turbo,jpegli,$(vips-all_DEPS))
vips-web_DEPS       := $(subst libjpeg-turbo,jpegli,$(vips-web_DEPS))
