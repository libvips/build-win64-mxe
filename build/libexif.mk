PKG             := libexif
$(PKG)_WEBSITE  := https://libexif.github.io/
$(PKG)_DESCR    := A library for parsing, editing, and saving EXIF data.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.23
$(PKG)_CHECKSUM := a740a99920eb81ae0aa802bb46e683ce6e0cde061c210f5d5bde5b8572380431
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_GH_CONF  := libexif/libexif/releases,v,,,,.tar.xz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef
