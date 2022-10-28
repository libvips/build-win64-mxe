PKG             := openslide
$(PKG)_WEBSITE  := https://openslide.org/
$(PKG)_DESCR    := C library for reading virtual slide images.
$(PKG)_IGNORE   :=
# https://github.com/Path-AI/openslide/tarball/be1aeb59e3bd73efaca0c1c002f86f098b420efb
$(PKG)_VERSION  := be1aeb5
$(PKG)_CHECKSUM := 6deeacc74e0d78a65c4d3f370150f3bbe359cabb0db9d399fb090efa7707628b
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := Path-AI/openslide/branches/dp200-support-with-tests
$(PKG)_DEPS     := cc zlib cairo gdk-pixbuf libjpeg-turbo tiff openjpeg sqlite

define $(PKG)_BUILD
    # This can be removed once the patch "openslide-3-fixes.patch" is accepted by upstream
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'

    # Build and run the code generator manually
    # https://github.com/openslide/openslide/issues/131
    cd '$(SOURCE_DIR)' && $(BUILD_CC) -O2 \
        src/make-tables.c \
        -lm \
        -o make-tables
    '$(SOURCE_DIR)/make-tables' '$(SOURCE_DIR)/src/openslide-tables.c'

    # Allow libtool to statically link against libintl
    # by specifying lt_cv_deplibs_check_method="pass_all"
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        $(if $(IS_INTL_DUMMY), lt_cv_deplibs_check_method="pass_all")

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
endef
