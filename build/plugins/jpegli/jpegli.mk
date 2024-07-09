PKG             := jpegli
$(PKG)_WEBSITE  := https://github.com/google/jpegli
$(PKG)_DESCR    := Improved JPEG encoder and decoder implementation
$(PKG)_IGNORE   :=
# https://github.com/google/jpegli/tarball/d0d9b8c256b10b7fa6b5d7d35a2ad65d543a6940
$(PKG)_VERSION  := d0d9b8c
$(PKG)_CHECKSUM := 12f1b98546d0b305150bac59331e894a946320e2e866219e686d0a3483d97bbd
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/jpegli/branches/main
$(PKG)_DEPS     := cc highway lcms libjpeg-turbo

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_TESTING=OFF \
        -DJPEGXL_ENABLE_TOOLS=OFF \
        -DJPEGXL_ENABLE_DOXYGEN=OFF \
        -DJPEGXL_ENABLE_MANPAGES=OFF \
        -DJPEGXL_ENABLE_BENCHMARK=OFF \
        -DJPEGXL_ENABLE_SJPEG=OFF \
        -DJPEGXL_ENABLE_OPENEXR=OFF \
        -DJPEGXL_ENABLE_SKCMS=OFF \
        -DJPEGXL_FORCE_SYSTEM_LCMS2=ON \
        -DJPEGXL_FORCE_SYSTEM_HWY=ON \
        -DJPEGXL_FORCE_SYSTEM_JPEG_TURBO=ON \
        -DJPEGXL_INSTALL_JPEGLI_LIBJPEG=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
