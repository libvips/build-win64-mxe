PKG             := vips-web
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.0
$(PKG)_CHECKSUM := 33b9d641fdb5776bd034a2fb58a9cccf4f873e7afd5ec3fd3f9dc0a4907c758e
$(PKG)_GH_CONF  := jcupitt/libvips/releases/download,v,-rc1
$(PKG)_SUBDIR   := $(subst -web,,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(subst -web,,$(PKG))-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango fftw \
                   libgsf libjpeg-turbo tiff lcms libexif libpng

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-magick \
        --without-openslide \
        --without-poppler \
        --without-OpenEXR \
        --without-matio \
        --without-ppm \
        --without-analyze \
        --without-radiance \
        --disable-introspection \
        --with-jpeg-includes='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-libraries='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        CFLAGS='-O3' \
        CXXFLAGS='-O3'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
