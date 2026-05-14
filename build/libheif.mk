PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
# https://github.com/strukturag/libheif/tarball/580ca121af7cc4c608473159a6cf6b977d99e9e0
$(PKG)_VERSION  := 580ca12
$(PKG)_CHECKSUM := 99b21e67cd0b6dea67af010cda895e2c8d56a3633e8516d63cf18fe1a1546ed6
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/branches/master
$(PKG)_DEPS     := cc aom

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DENABLE_PLUGIN_LOADING=0 \
        -DBUILD_TESTING=0 \
        -DWITH_EXAMPLES=0 \
        $(if $(IS_HEVC),, \
            -DWITH_LIBDE265=0 \
            -DWITH_X265=0) \
        $(if $(and $(IS_JPEGLI),$(BUILD_STATIC)), -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -DHAVE_JPEG_WRITE_ICC_PROFILE') \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
