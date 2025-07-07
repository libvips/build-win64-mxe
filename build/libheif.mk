PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.20.1
$(PKG)_CHECKSUM := 55cc76b77c533151fc78ba58ef5ad18562e84da403ed749c3ae017abaf1e2090
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/releases,v
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
