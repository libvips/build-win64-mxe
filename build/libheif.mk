PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.20.2
$(PKG)_CHECKSUM := 68ac9084243004e0ef3633f184eeae85d615fe7e4444373a0a21cebccae9d12a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/releases,v
$(PKG)_DEPS     := cc dav1d rav1e

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DENABLE_PLUGIN_LOADING=0 \
        -DWITH_DAV1D_PLUGIN=0 \
        -DWITH_RAV1E_PLUGIN=0 \
        -DBUILD_TESTING=0 \
        -DWITH_EXAMPLES=0 \
        $(if $(IS_AOM),, \
            -DWITH_AOM_DECODER=0 \
            -DWITH_AOM_ENCODER=0 \
            -DWITH_DAV1D=1 \
            -DWITH_RAV1E=1) \
        $(if $(IS_HEVC),, \
            -DWITH_LIBDE265=0 \
            -DWITH_X265=0) \
        $(if $(and $(IS_JPEGLI),$(BUILD_STATIC)), -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -DHAVE_JPEG_WRITE_ICC_PROFILE') \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
