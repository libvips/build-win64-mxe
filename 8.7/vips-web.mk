PKG             := vips-web
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.7.0
$(PKG)_CHECKSUM := dbaacd7cf19a6c7f55fef012d80b60e586240905be47426d23752a4b84c334bb
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/libvips/releases/download,v,-rc2
$(PKG)_SUBDIR   := $(subst -web,,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(subst -web,,$(PKG))-$($(PKG)_VERSION)-rc2.tar.gz
$(PKG)_URL      := https://github.com/jcupitt/libvips/releases/download/v$($(PKG)_VERSION)-rc2/$($(PKG)_FILE)
$(PKG)_DEPS     := cc libwebp librsvg giflib glib pango fftw \
                   libgsf libjpeg-turbo tiff lcms libexif libpng

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
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
        --disable-introspection \
        --with-jpeg-includes='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-libraries='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        CFLAGS='-O3' \
        CXXFLAGS='-O3'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
