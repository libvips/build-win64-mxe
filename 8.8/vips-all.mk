PKG             := vips-all
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 91d0e7e
$(PKG)_CHECKSUM := 762cc61d5abfb0f3b4ba6e8e82f23739ade89e09ac5c5128b1e9c30daebe0b71
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/branches/master
$(PKG)_DEPS     := cc matio libwebp librsvg giflib poppler glib pango fftw \
                   libgsf libjpeg-turbo tiff openslide lcms libexif libheif \
                   imagemagick libpng openexr cfitsio nifticlib orc

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
        --without-pdfium \
        --without-imagequant \
        --disable-introspection

    $(MAKE) -C '$(SOURCE_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(SOURCE_DIR)' -j 1 install
endef
