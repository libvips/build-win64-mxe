PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := e14ae48
$(PKG)_CHECKSUM := 6d13912c221cc436c55ea6f0af03bc9113d3b6acb68a0f93ac24198981a0da97
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/branches/master
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango libgsf \
                   libjpeg-turbo tiff lcms libexif libpng orc

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(TOP_DIR)/vips-packaging
    $(foreach f,COPYING ChangeLog README.md AUTHORS, mv '$(SOURCE_DIR)/$f' '$(TOP_DIR)/vips-packaging';)
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)
    cd '$(SOURCE_DIR)' && ./autogen.sh \
        $(MXE_CONFIGURE_OPTS) \
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
        --disable-introspection

    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install

    $(if $(BUILD_STATIC), \
        $(MAKE_SHARED_FROM_STATIC) --libprefix 'lib' --libsuffix '-42' \
        '$(SOURCE_DIR)/libvips/.libs/libvips.a' \
        `$(TARGET)-pkg-config --libs-only-l vips` -luserenv -ldnsapi -liphlpapi -lcairo-gobject -lgif)
endef
