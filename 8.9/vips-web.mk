PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.9.1
$(PKG)_CHECKSUM := 45633798877839005016c9d3494e98dee065f5cb9e20f4552d3b315b8e8bce91
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/releases,v
$(PKG)_SUBDIR   := vips-$($(PKG)_VERSION)
$(PKG)_FILE     := vips-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango libgsf \
                   libjpeg-turbo tiff lcms libexif libpng orc

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(TOP_DIR)/vips-packaging
    $(foreach f,COPYING ChangeLog README.md AUTHORS, mv '$(SOURCE_DIR)/$f' '$(TOP_DIR)/vips-packaging';)

    (printf '{\n'; \
     printf '  "cairo": "$(cairo_VERSION)",\n'; \
     printf '  "exif": "$(libexif_VERSION)",\n'; \
     printf '  "expat": "$(expat_VERSION)",\n'; \
     printf '  "ffi": "$(libffi_VERSION)",\n'; \
     printf '  "fontconfig": "$(fontconfig_VERSION)",\n'; \
     printf '  "freetype": "$(freetype_VERSION)",\n'; \
     printf '  "fribidi": "$(fribidi_VERSION)",\n'; \
     printf '  "gdkpixbuf": "$(gdk-pixbuf_VERSION)",\n'; \
     printf '  "gettext": "$(gettext_VERSION)",\n'; \
     printf '  "gif": "$(giflib_VERSION)",\n'; \
     printf '  "glib": "$(glib_VERSION)",\n'; \
     printf '  "gsf": "$(libgsf_VERSION)",\n'; \
     printf '  "harfbuzz": "$(harfbuzz_VERSION)",\n'; \
     printf '  "iconv": "$(libiconv_VERSION)",\n'; \
     printf '  "jpeg": "$(libjpeg-turbo_VERSION)",\n'; \
     printf '  "lcms": "$(lcms_VERSION)",\n'; \
     printf '  "orc": "$(orc_VERSION)",\n'; \
     printf '  "pango": "$(pango_VERSION)",\n'; \
     printf '  "pixman": "$(pixman_VERSION)",\n'; \
     printf '  "png": "$(libpng_VERSION)",\n'; \
     printf '  "svg": "$(librsvg_VERSION)",\n'; \
     printf '  "tiff": "$(tiff_VERSION)",\n'; \
     printf '  "vips": "$(vips-web_VERSION)",\n'; \
     printf '  "webp": "$(libwebp_VERSION)",\n'; \
     printf '  "xml": "$(libxml2_VERSION)",\n'; \
     printf '  "zlib": "$(zlib_VERSION)"\n'; \
     printf '}';) \
     > '$(TOP_DIR)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    # Always build as shared library, we need
    # libvips-42.dll for the language bindings.
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        --host='$(TARGET)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --disable-static \
        --enable-shared \
        $(MXE_DISABLE_DOC_OPTS) \
        --enable-debug=no \
        --without-fftw \
        --without-magick \
        --without-heif \
        --without-openslide \
        --without-pdfium \
        --without-poppler \
        --without-cfitsio \
        --without-OpenEXR \
        --without-nifti \
        --without-matio \
        --without-ppm \
        --without-analyze \
        --without-radiance \
        --without-imagequant \
        --disable-introspection \
        $(if $(findstring posix,$(TARGET)), CXXFLAGS="$(CXXFLAGS) -Wno-incompatible-ms-struct") \
        $(if $(BUILD_STATIC), lt_cv_deplibs_check_method="pass_all")

    # libtool should automatically generate a list
    # of exported symbols, even for "static" builds
    $(if $(BUILD_STATIC), \
        $(SED) -i 's/^always_export_symbols=no/always_export_symbols=yes/g' '$(BUILD_DIR)/libtool')

    # remove -nostdlib from linker commandline options
    # https://debbugs.gnu.org/cgi/bugreport.cgi?bug=27866
    $(if $(findstring posix,$(TARGET)), \
        $(SED) -i '/^archive_cmds=/s/\-nostdlib//g' '$(BUILD_DIR)/libtool')

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
