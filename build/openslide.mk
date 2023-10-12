PKG             := openslide
$(PKG)_WEBSITE  := https://openslide.org/
$(PKG)_DESCR    := C library for reading virtual slide images.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.0.0
$(PKG)_CHECKSUM := cc227c44316abb65fb28f1c967706eb7254f91dbfab31e9ae6a48db6cf4ae562
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := openslide/openslide/releases,v,,,,.tar.xz
$(PKG)_DEPS     := cc zlib glib libxml2 cairo gdk-pixbuf libjpeg-turbo tiff openjpeg sqlite libdicom

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dtest=disabled \
        -Ddoc=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
