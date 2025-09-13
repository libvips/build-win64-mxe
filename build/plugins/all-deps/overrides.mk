$(PLUGIN_HEADER)

# OpenSlide needs -Dxpath=enabled
# ImageMagick's internal MSVG parser needs -Dpush=enabled -Dsax1=enabled
libxml2_MESON_OPTS = -Dxpath=enabled -Dpush=enabled -Dsax1=enabled

# Patch to ensure the DLL directory is used as libdir
vips_PATCHES := $(vips_PATCHES) \
                $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))

vips_MESON_OPTS = \
    -Dmodules=enabled \
    -Dheif-module=$(if $(IS_HEVC),enabled,disabled) \
    $(if $(findstring graphicsmagick,$(vips_all_DEPS)), -Dmagick-package=GraphicsMagick) \
    -Dpdfium=disabled \
    -Dquantizr=disabled

# https://github.com/libvips/build-win64-mxe/issues/80
tiff_CONFIGURE_OPTS = --enable-zstd

# Override sub-dependencies
tiff_DEPS := $(tiff_DEPS) zstd
