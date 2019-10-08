PKG             := vips-all
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
# https://api.github.com/repos/libvips/libvips/tarball/be7c1404c321917c602c1fb3f54da009a92bef0d
$(PKG)_VERSION  := be7c140
$(PKG)_CHECKSUM := 7296aad5056c87b30dfe75d9bc200e029b99b52b2c4b20dc3c5fd76f80f340fa
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/branches/master
$(PKG)_DEPS     := cc matio libwebp librsvg giflib poppler glib pango fftw \
                   libgsf libjpeg-turbo tiff openslide lcms libexif libheif \
                   imagemagick libpng openexr cfitsio nifticlib orc

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(TOP_DIR)/vips-packaging
    $(foreach f,COPYING ChangeLog README.md AUTHORS, mv '$(SOURCE_DIR)/$f' '$(TOP_DIR)/vips-packaging';)

    (echo '{'; \
     echo '  "cairo": "$(cairo_VERSION)",'; \
     echo '  "cfitsio": "$(cfitsio_VERSION)",'; \
     echo '  "croco": "$(libcroco_VERSION)",'; \
     echo '  "de265": "$(libde265_VERSION)",'; \
     echo '  "exif": "$(libexif_VERSION)",'; \
     echo '  "expat": "$(expat_VERSION)",'; \
     echo '  "ffi": "$(libffi_VERSION)",'; \
     echo '  "fftw": "$(fftw_VERSION)",'; \
     echo '  "fontconfig": "$(fontconfig_VERSION)",'; \
     echo '  "freetype": "$(freetype_VERSION)",'; \
     echo '  "fribidi": "$(fribidi_VERSION)",'; \
     echo '  "gdkpixbuf": "$(gdk-pixbuf_VERSION)",'; \
     echo '  "gettext": "$(gettext_VERSION)",'; \
     echo '  "gif": "$(giflib_VERSION)",'; \
     echo '  "glib": "$(glib_VERSION)",'; \
     echo '  "gsf": "$(libgsf_VERSION)",'; \
     echo '  "harfbuzz": "$(harfbuzz_VERSION)",'; \
     echo '  "hdf5": "$(hdf5_VERSION)",'; \
     echo '  "heif": "$(libheif_VERSION)",'; \
     echo '  "iconv": "$(libiconv_VERSION)",'; \
     echo '  "imagemagick": "$(imagemagick_VERSION)",'; \
     echo '  "jpeg": "$(libjpeg-turbo_VERSION)",'; \
     echo '  "lcms": "$(lcms_VERSION)",'; \
     echo '  "matio": "$(matio_VERSION)",'; \
     echo '  "nifti": "$(nifticlib_VERSION)",'; \
     echo '  "openexr": "$(openexr_VERSION)",'; \
     echo '  "openjpeg": "$(openjpeg_VERSION)",'; \
     echo '  "openslide": "$(openslide_VERSION)",'; \
     echo '  "orc": "$(orc_VERSION)",'; \
     echo '  "pango": "$(pango_VERSION)",'; \
     echo '  "pixman": "$(pixman_VERSION)",'; \
     echo '  "png": "$(libpng_VERSION)",'; \
     echo '  "poppler": "$(poppler_VERSION)",'; \
     echo '  "sqlite": "$(sqlite_VERSION)",'; \
     echo '  "svg": "$(librsvg_VERSION)",'; \
     echo '  "tiff": "$(tiff_VERSION)",'; \
     echo '  "vips": "$(vips-all_VERSION)",'; \
     echo '  "webp": "$(libwebp_VERSION)",'; \
     echo '  "x265": "$(x265_VERSION)",'; \
     echo '  "xml": "$(libxml2_VERSION)",'; \
     echo '  "zlib": "$(zlib_VERSION)"'; \
     echo '}';) \
     > '$(TOP_DIR)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)
    cd '$(SOURCE_DIR)' && ./autogen.sh \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-pdfium \
        --without-imagequant \
        --disable-introspection

    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
endef
