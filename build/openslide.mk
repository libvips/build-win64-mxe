PKG             := openslide
$(PKG)_WEBSITE  := https://openslide.org/
$(PKG)_DESCR    := C library for reading virtual slide images.
$(PKG)_IGNORE   :=
# https://github.com/openslide/openslide/tarball/642b057b1e15f7c83eadd651c092724e993e8700
$(PKG)_VERSION  := 642b057
$(PKG)_CHECKSUM := 626ff7d04b926d79187f65b2ed7816519b1d691eea33f36d6995126baeeaaaba
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := openslide/openslide/branches/main
$(PKG)_DEPS     := cc zlib glib libxml2 cairo gdk-pixbuf libjpeg-turbo tiff openjpeg sqlite

define $(PKG)_BUILD
    # TODO(kleisauke): Build against libdicom
    $(MXE_MESON_WRAPPER) \
        -Ddicom=disabled \
        -Dtest=disabled \
        -Ddoc=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
