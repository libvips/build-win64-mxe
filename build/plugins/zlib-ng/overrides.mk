$(PLUGIN_HEADER)

IS_ZLIB_NG := $(true)

# Override sub-dependencies
freetype_DEPS           := $(subst zlib,zlib-ng,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst zlib,zlib-ng,$(freetype-bootstrap_DEPS))
glib_DEPS               := $(subst zlib,zlib-ng,$(glib_DEPS))
lcms_DEPS               := $(subst zlib,zlib-ng,$(lcms_DEPS))
libexif_DEPS            := $(subst zlib,zlib-ng,$(libexif_DEPS))
libgsf_DEPS             := $(subst zlib,zlib-ng,$(libgsf_DEPS))
libpng_DEPS             := $(subst zlib,zlib-ng,$(libpng_DEPS))
libspng_DEPS            := $(subst zlib,zlib-ng,$(libspng_DEPS))
libxml2_DEPS            := $(subst zlib,zlib-ng,$(libxml2_DEPS))
matio_DEPS              := $(subst zlib,zlib-ng,$(matio_DEPS))
nifticlib_DEPS          := $(subst zlib,zlib-ng,$(nifticlib_DEPS))
openexr_DEPS            := $(subst zlib,zlib-ng,$(openexr_DEPS))
openjpeg_DEPS           := $(subst zlib,zlib-ng,$(openjpeg_DEPS))
openslide_DEPS          := $(subst zlib,zlib-ng,$(openslide_DEPS))
poppler_DEPS            := $(subst zlib,zlib-ng,$(poppler_DEPS))
tiff_DEPS               := $(subst zlib,zlib-ng,$(tiff_DEPS))

# Disable the zlib build, just to be sure
zlib_BUILD_x86_64-w64-mingw32  =
zlib_BUILD_i686-w64-mingw32    =
zlib_BUILD_aarch64-w64-mingw32 =
zlib_BUILD_armv7-w64-mingw32   =
