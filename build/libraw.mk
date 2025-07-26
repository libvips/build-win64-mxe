PKG             := libraw
$(PKG)_WEBSITE  := https://www.libraw.org
$(PKG)_DESCR    := Load many camera RAW formats
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.21.4
$(PKG)_CHECKSUM := 6be43f19397e43214ff56aab056bf3ff4925ca14012ce5a1538a172406a09e63
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := LibRaw-$($(PKG)_VERSION)
$(PKG)_FILE     := LibRaw-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://www.libraw.org/data/$($(PKG)_FILE)

# we can't use --enable-openmp without pthreads support
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
	--disable-examples \
	--enable-jpeg \
	--enable-jasper \
	--enable-zlib \
	--enable-lcms

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)
endef
