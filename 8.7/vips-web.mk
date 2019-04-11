PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.4
$(PKG)_CHECKSUM := ce7518a8f31b1d29a09b3d7c88e9852a5a2dcb3ee1501524ab477e433383f205
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/releases/download,v
$(PKG)_SUBDIR   := $(subst -web,,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(subst -web,,$(PKG))-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango libgsf \
                   libjpeg-turbo tiff lcms libexif libpng orc

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(TOP_DIR)/vips-packaging
    $(foreach f,COPYING ChangeLog README.md AUTHORS, mv '$(SOURCE_DIR)/$f' '$(TOP_DIR)/vips-packaging';)

    (echo '{'; \
     echo '  "cairo": "$(cairo_VERSION)",'; \
     echo '  "croco": "$(libcroco_VERSION)",'; \
     echo '  "exif": "$(libexif_VERSION)",'; \
     echo '  "expat": "$(expat_VERSION)",'; \
     echo '  "ffi": "$(libffi_VERSION)",'; \
     echo '  "fontconfig": "$(fontconfig_VERSION)",'; \
     echo '  "freetype": "$(freetype_VERSION)",'; \
     echo '  "fribidi": "$(fribidi_VERSION)",'; \
     echo '  "gdkpixbuf": "$(gdk-pixbuf_VERSION)",'; \
     echo '  "gettext": "$(gettext_VERSION)",'; \
     echo '  "gif": "$(giflib_VERSION)",'; \
     echo '  "glib": "$(glib_VERSION)",'; \
     echo '  "gsf": "$(libgsf_VERSION)",'; \
     echo '  "harfbuzz": "$(harfbuzz_VERSION)",'; \
     echo '  "iconv": "$(libiconv_VERSION)",'; \
     echo '  "jpeg": "$(libjpeg-turbo_VERSION)",'; \
     echo '  "lcms": "$(lcms_VERSION)",'; \
     echo '  "orc": "$(orc_VERSION)",'; \
     echo '  "pango": "$(pango_VERSION)",'; \
     echo '  "pixman": "$(pixman_VERSION)",'; \
     echo '  "png": "$(libpng_VERSION)",'; \
     echo '  "svg": "$(librsvg_VERSION)",'; \
     echo '  "tiff": "$(tiff_VERSION)",'; \
     echo '  "vips": "$(vips-web_VERSION)",'; \
     echo '  "webp": "$(libwebp_VERSION)",'; \
     echo '  "xml": "$(libxml2_VERSION)",'; \
     echo '  "zlib": "$(zlib_VERSION)"'; \
     echo '}';) \
     > '$(TOP_DIR)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-fftw \
        --without-magick \
        --without-openslide \
        --without-poppler \
        --without-cfitsio \
        --without-OpenEXR \
        --without-nifti \
        --without-matio \
        --without-ppm \
        --without-analyze \
        --without-radiance \
        --disable-introspection

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(if $(BUILD_STATIC), \
        $(MAKE_SHARED_FROM_STATIC) --libprefix 'lib' --libsuffix '-42' \
        '$(BUILD_DIR)/libvips/.libs/libvips.a' \
        `$(TARGET)-pkg-config --libs-only-l vips` -luserenv -ldnsapi -liphlpapi -lcairo-gobject -lgif)
endef
