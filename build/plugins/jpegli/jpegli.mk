PKG             := jpegli
$(PKG)_WEBSITE  := https://github.com/google/jpegli
$(PKG)_DESCR    := Improved JPEG encoder and decoder implementation
$(PKG)_IGNORE   :=
# https://github.com/google/jpegli/tarball/7cdf212790241868c77dca777dbee14e98128cba
$(PKG)_VERSION  := 7cdf212
$(PKG)_CHECKSUM := 95986bb49501c73b51feab948edd6bd05ba550e3545e65430042f434f56c457a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/jpegli/branches/main
$(PKG)_DEPS     := cc highway lcms libjpeg-turbo

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DBUILD_TESTING=OFF \
        -DJPEGLI_ENABLE_TOOLS=OFF \
        -DJPEGLI_ENABLE_DOXYGEN=OFF \
        -DJPEGLI_ENABLE_MANPAGES=OFF \
        -DJPEGLI_ENABLE_BENCHMARK=OFF \
        -DJPEGLI_ENABLE_SJPEG=OFF \
        -DJPEGLI_ENABLE_OPENEXR=OFF \
        -DJPEGLI_ENABLE_SKCMS=OFF \
        -DJPEGLI_FORCE_SYSTEM_LCMS2=ON \
        -DJPEGLI_FORCE_SYSTEM_HWY=ON \
        -DJPEGLI_FORCE_SYSTEM_JPEG_TURBO=ON \
        -DJPEGLI_INSTALL_JPEGLI_LIBJPEG=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
