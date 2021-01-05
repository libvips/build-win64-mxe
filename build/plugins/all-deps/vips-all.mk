PKG             := vips-all
$(PKG)_WEBSITE   = $(vips_WEBSITE)
$(PKG)_DESCR     = $(vips_DESCR)
$(PKG)_IGNORE    = $(vips_IGNORE)
$(PKG)_VERSION   = $(vips_VERSION)
$(PKG)_CHECKSUM  = $(vips_CHECKSUM)
$(PKG)_PATCHES   = $(vips_PATCHES)
$(PKG)_SUBDIR    = $(vips_SUBDIR)
$(PKG)_FILE      = $(vips_FILE)
$(PKG)_URL       = $(vips_URL)
$(PKG)_DEPS     := $(vips_DEPS) imagemagick matio openexr cfitsio \
                   nifticlib poppler fftw openslide libjxl libraw

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p '$(PREFIX)/$(TARGET)/vips-packaging'
    $(foreach f, ChangeLog LICENSE README.md, \
        cp '$(SOURCE_DIR)/$(f)' '$(PREFIX)/$(TARGET)/vips-packaging';)

    (printf '{\n'; \
     $(if $(IS_AOM),printf '  "aom": "$(aom_VERSION)"$(comma)\n';) \
     printf '  "archive": "$(libarchive_VERSION)",\n'; \
     printf '  "brotli": "$(brotli_VERSION)",\n'; \
     printf '  "cairo": "$(cairo_VERSION)",\n'; \
     $(if $(IS_AOM),,printf '  "dav1d": "$(dav1d_VERSION)"$(comma)\n';) \
     printf '  "cfitsio": "$(cfitsio_VERSION)",\n'; \
     printf '  "cgif": "$(cgif_VERSION)",\n'; \
     $(if $(IS_HEVC),printf '  "de265": "$(libde265_VERSION)"$(comma)\n';) \
     printf '  "dicom": "$(libdicom_VERSION)",\n'; \
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
     printf '  "harfbuzz": "$(harfbuzz_VERSION)",\n'; \
     printf '  "heif": "$(libheif_VERSION)",\n'; \
     printf '  "highway": "$(highway_VERSION)",\n'; \
     $(if $(findstring imagemagick,$($(PKG)_DEPS)),printf '  "imagemagick": "$(imagemagick_VERSION)"$(comma)\n';) \
     printf '  "imagequant": "$(libimagequant_VERSION)",\n'; \
     $(if $(IS_JPEGLI), \
          printf '  "jpegli": "$(jpegli_VERSION)"$(comma)\n';, \
          $(if $(IS_MOZJPEG),,printf '  "jpeg": "$(libjpeg-turbo_VERSION)"$(comma)\n';)) \
     printf '  "jxl": "$(libjxl_VERSION)",\n'; \
     printf '  "lcms": "$(lcms_VERSION)",\n'; \
     printf '  "matio": "$(matio_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),printf '  "mozjpeg": "$(mozjpeg_VERSION)"$(comma)\n';) \
     printf '  "nifti": "$(nifticlib_VERSION)",\n'; \
     printf '  "openexr": "$(openexr_VERSION)",\n'; \
     printf '  "openjpeg": "$(openjpeg_VERSION)",\n'; \
     printf '  "openslide": "$(openslide_VERSION)",\n'; \
     printf '  "pango": "$(pango_VERSION)",\n'; \
     printf '  "pixman": "$(pixman_VERSION)",\n'; \
     printf '  "png": "$(libpng_VERSION)",\n'; \
     printf '  "poppler": "$(poppler_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),printf '  "proxy-libintl": "$(proxy-libintl_VERSION)"$(comma)\n';) \
     $(if $(IS_AOM),,printf '  "rav1e": "$(rav1e_VERSION)"$(comma)\n';) \
     printf '  "raw": "$(libraw_VERSION)",\n'; \
     printf '  "rsvg": "$(librsvg_VERSION)",\n'; \
     printf '  "spng": "$(libspng_VERSION)",\n'; \
     printf '  "sqlite": "$(sqlite_VERSION)",\n'; \
     printf '  "tiff": "$(tiff_VERSION)",\n'; \
     printf '  "vips": "$(vips_VERSION)",\n'; \
     printf '  "webp": "$(libwebp_VERSION)",\n'; \
     $(if $(IS_HEVC),printf '  "x265": "$(x265_VERSION)"$(comma)\n';) \
     printf '  "xml2": "$(libxml2_VERSION)",\n'; \
     $(if $(IS_ZLIB_NG), \
          printf '  "zlib-ng": "$(zlib-ng_VERSION)"$(comma)\n';, \
          printf '  "zlib": "$(zlib_VERSION)"$(comma)\n';) \
     printf '  "zstd": "$(zstd_VERSION)"\n'; \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(vips_BUILD)
endef
