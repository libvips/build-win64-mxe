PKG             := libexif
$(PKG)_WEBSITE  := https://libexif.github.io/
$(PKG)_DESCR    := A library for parsing, editing, and saving EXIF data.
$(PKG)_IGNORE   :=
# https://github.com/libexif/libexif/issues/12
$(PKG)_VERSION  := 154189b
$(PKG)_CHECKSUM := 907c052c0c3861824629ffe40ad2821626606b4e4270c6fed95a41b42575c497
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libexif/libexif/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://sourceforge.net/projects/libexif/files/libexif/' | \
    $(SED) -n 's,.*<tr title="\([0-9][^"]*\)".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    # configure script is ancient so regenerate
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef
