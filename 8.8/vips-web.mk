PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8e55732
$(PKG)_CHECKSUM := 2a9431ed266113c10ec248abf614a0f4f386ff7f01e9a125a228c9d8a6183af1
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
