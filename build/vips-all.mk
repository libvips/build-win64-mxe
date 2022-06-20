PKG             := vips-all
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.13.0
$(PKG)_CHECKSUM := 3bce6ada3c18a38f59a8f51297ed59b19ab8ca1076770c715f0d33de19842d2a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))
$(PKG)_SUBDIR   := libvips-$($(PKG)_VERSION)-rc1
$(PKG)_GH_CONF  := libvips/libvips/tags,v,-rc1
$(PKG)_DEPS     := cc meson-wrapper libwebp librsvg glib pango libgsf \
                   libjpeg-turbo tiff lcms libexif libheif libpng \
                   libspng libimagequant orc imagemagick matio openexr \
                   cfitsio nifticlib poppler fftw openslide libjxl cgif

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(PREFIX)/$(TARGET)/vips-packaging
    $(foreach f, COPYING ChangeLog README.md AUTHORS, \
        cp '$(SOURCE_DIR)/$(f)' '$(PREFIX)/$(TARGET)/vips-packaging';)

    (printf '{\n'; \
     printf '  "aom": "$(aom_VERSION)",\n'; \
     $(if $(IS_LLVM),printf '  "brotli": "$(brotli_VERSION)"$(comma)\n';) \
     printf '  "cairo": "$(cairo_VERSION)",\n'; \
     printf '  "cfitsio": "$(cfitsio_VERSION)",\n'; \
     printf '  "cgif": "$(cgif_VERSION)",\n'; \
     $(if $(IS_HEVC),printf '  "de265": "$(libde265_VERSION)"$(comma)\n';) \
     printf '  "exif": "$(libexif_VERSION)",\n'; \
     printf '  "expat": "$(expat_VERSION)",\n'; \
     printf '  "ffi": "$(libffi_VERSION)",\n'; \
     printf '  "fftw": "$(fftw_VERSION)",\n'; \
     printf '  "fontconfig": "$(fontconfig_VERSION)",\n'; \
     printf '  "freetype": "$(freetype_VERSION)",\n'; \
     printf '  "fribidi": "$(fribidi_VERSION)",\n'; \
     printf '  "gdkpixbuf": "$(gdk-pixbuf_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),,printf '  "gettext": "$(gettext_VERSION)"$(comma)\n';) \
     printf '  "glib": "$(glib_VERSION)",\n'; \
     $(if $(findstring graphicsmagick,$($(PKG)_DEPS)),printf '  "graphicsmagick": "$(graphicsmagick_VERSION)"$(comma)\n';) \
     printf '  "gsf": "$(libgsf_VERSION)",\n'; \
     printf '  "harfbuzz": "$(harfbuzz_VERSION)",\n'; \
     printf '  "heif": "$(libheif_VERSION)",\n'; \
     $(if $(IS_LLVM),printf '  "highway": "$(highway_VERSION)"$(comma)\n';) \
     $(if $(findstring imagemagick,$($(PKG)_DEPS)),printf '  "imagemagick": "$(imagemagick_VERSION)"$(comma)\n';) \
     printf '  "imagequant": "$(libimagequant_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),,printf '  "jpeg": "$(libjpeg-turbo_VERSION)"$(comma)\n';) \
     $(if $(IS_LLVM),printf '  "jxl": "$(libjxl_VERSION)"$(comma)\n';) \
     printf '  "lcms": "$(lcms_VERSION)",\n'; \
     printf '  "matio": "$(matio_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),printf '  "mozjpeg": "$(mozjpeg_VERSION)"$(comma)\n';) \
     printf '  "nifti": "$(nifticlib_VERSION)",\n'; \
     printf '  "openexr": "$(openexr_VERSION)",\n'; \
     printf '  "openjpeg": "$(openjpeg_VERSION)",\n'; \
     printf '  "openslide": "$(openslide_VERSION)",\n'; \
     printf '  "orc": "$(orc_VERSION)",\n'; \
     printf '  "pango": "$(pango_VERSION)",\n'; \
     printf '  "pixman": "$(pixman_VERSION)",\n'; \
     printf '  "png": "$(libpng_VERSION)",\n'; \
     printf '  "poppler": "$(poppler_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),printf '  "proxy-libintl": "$(proxy-libintl_VERSION)"$(comma)\n';) \
     printf '  "sqlite": "$(sqlite_VERSION)",\n'; \
     printf '  "svg": "$(librsvg_VERSION)",\n'; \
     printf '  "spng": "$(libspng_VERSION)",\n'; \
     printf '  "tiff": "$(tiff_VERSION)",\n'; \
     printf '  "vips": "$(vips-all_VERSION)",\n'; \
     printf '  "webp": "$(libwebp_VERSION)",\n'; \
     $(if $(IS_HEVC),printf '  "x265": "$(x265_VERSION)"$(comma)\n';) \
     printf '  "xml": "$(libxml2_VERSION)",\n'; \
     $(if $(IS_ZLIB_NG), \
          printf '  "zlib-ng": "$(zlib-ng_VERSION)"\n';, \
          printf '  "zlib": "$(zlib_VERSION)"\n';) \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(MXE_MESON_WRAPPER) \
        -Ddeprecated=false \
        -Dintrospection=false \
        -Dmodules=enabled \
        -Dheif-module=$(if $(IS_HEVC),enabled,disabled) \
        -Djpeg-xl=$(if $(IS_LLVM),enabled,disabled) \
        $(if $(findstring graphicsmagick,$($(PKG)_DEPS)), -Dmagick-package=GraphicsMagick) \
        -Dpdfium=disabled \
        -Dquantizr=disabled \
        -Dc_args='$(CFLAGS) -DVIPS_DLLDIR_AS_LIBDIR' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
