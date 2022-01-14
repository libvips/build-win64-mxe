$(PLUGIN_HEADER)

IS_ZLIB_NG := $(true)

# Override sub-dependencies
cairo_DEPS              := $(subst zlib,zlib-ng,$(cairo_DEPS))
cfitsio_DEPS            := $(subst zlib,zlib-ng,$(cfitsio_DEPS))
freetype_DEPS           := $(subst zlib,zlib-ng,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst zlib,zlib-ng,$(freetype-bootstrap_DEPS))
glib_DEPS               := $(subst zlib,zlib-ng,$(glib_DEPS))
lcms_DEPS               := $(subst zlib,zlib-ng,$(lcms_DEPS))
libarchive_DEPS         := $(subst zlib,zlib-ng,$(libarchive_DEPS))
libexif_DEPS            := $(subst zlib,zlib-ng,$(libexif_DEPS))
libpng_DEPS             := $(subst zlib,zlib-ng,$(libpng_DEPS))
libspng_DEPS            := $(subst zlib,zlib-ng,$(libspng_DEPS))
openjpeg_DEPS           := $(subst zlib,zlib-ng,$(openjpeg_DEPS))
openslide_DEPS          := $(subst zlib,zlib-ng,$(openslide_DEPS))
poppler_DEPS            := $(subst zlib,zlib-ng,$(poppler_DEPS))
sqlite_DEPS             := $(subst zlib,zlib-ng,$(sqlite_DEPS))
tiff_DEPS               := $(subst zlib,zlib-ng,$(tiff_DEPS))

# Disable the zlib build, just to be sure
zlib_BUILD_x86_64-w64-mingw32  =
zlib_BUILD_i686-w64-mingw32    =
zlib_BUILD_aarch64-w64-mingw32 =
