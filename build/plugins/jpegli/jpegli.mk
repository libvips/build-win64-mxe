PKG             := jpegli
$(PKG)_WEBSITE  := https://github.com/google/jpegli
$(PKG)_DESCR    := Improved JPEG encoder and decoder implementation
$(PKG)_IGNORE   :=
# https://github.com/google/jpegli/tarball/5126d62d24d368f0ceadd53454653edeb9086386
$(PKG)_VERSION  := 5126d62
$(PKG)_CHECKSUM := 8f3680ce581d78a698099b9586ef2b448a6d81ecd9d1d356ba526fc87ea29bf1
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
