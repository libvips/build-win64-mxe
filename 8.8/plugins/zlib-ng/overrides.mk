$(PLUGIN_HEADER)

# Override zlib version for the versions.json file
# TODO: Wait for https://github.com/zlib-ng/zlib-ng/issues/64
zlib_VERSION := 1.2.11-git

# Override sub-dependencies
cairo_DEPS              := $(subst zlib,zlib-ng,$(cairo_DEPS))
freetype_DEPS           := $(subst zlib,zlib-ng,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst zlib,zlib-ng,$(freetype-bootstrap_DEPS))
glib_DEPS               := $(subst zlib,zlib-ng,$(glib_DEPS))
hdf5_DEPS               := $(subst zlib,zlib-ng,$(hdf5_DEPS))
lcms_DEPS               := $(subst zlib,zlib-ng,$(lcms_DEPS))
libexif_DEPS            := $(subst zlib,zlib-ng,$(libexif_DEPS))
libgsf_DEPS             := $(subst zlib,zlib-ng,$(libgsf_DEPS))
libpng_DEPS             := $(subst zlib,zlib-ng,$(libpng_DEPS))
libxml2_DEPS            := $(subst zlib,zlib-ng,$(libxml2_DEPS))
matio_DEPS              := $(subst zlib,zlib-ng,$(matio_DEPS))
nifticlib_DEPS          := $(subst zlib,zlib-ng,$(nifticlib_DEPS))
openexr_DEPS            := $(subst zlib,zlib-ng,$(openexr_DEPS))
openjpeg_DEPS           := $(subst zlib,zlib-ng,$(openjpeg_DEPS))
openslide_DEPS          := $(subst zlib,zlib-ng,$(openslide_DEPS))
poppler_DEPS            := $(subst zlib,zlib-ng,$(poppler_DEPS))
tiff_DEPS               := $(subst zlib,zlib-ng,$(tiff_DEPS))
