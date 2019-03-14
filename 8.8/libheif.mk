PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4.0
$(PKG)_CHECKSUM := 977a9831f1d61b5005566945c7e16e31de35a57a8dd6eb715ae0f40a3595cb60
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/releases/latest,v
$(PKG)_DEPS     := cc libde265 x265

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
