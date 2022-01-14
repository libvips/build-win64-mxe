$(PLUGIN_HEADER)

IS_MODULAR := $(true)

# OpenSlide needs -Dxpath=enabled
# ImageMagick's internal MSVG parser needs -Dpush=enabled -Dsax1=enabled
libxml2_MESON_OPTS = -Dxpath=enabled -Dpush=enabled -Dsax1=enabled

vips_DEPS := $(vips_DEPS) libjxl imagemagick openslide poppler
