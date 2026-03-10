PKG             := jpegli
$(PKG)_WEBSITE  := https://github.com/google/jpegli
$(PKG)_DESCR    := Improved JPEG encoder and decoder implementation
$(PKG)_IGNORE   :=
# https://github.com/google/jpegli/tarball/86eab85e9efd836d28337c5739b3e934e41ad80c
$(PKG)_VERSION  := 86eab85
$(PKG)_CHECKSUM := 9e913930fe9b745c622dd0d964c8772b931b2931f1e7a66f93411df37f67ee0a
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
