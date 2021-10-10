PKG             := libjxl
$(PKG)_WEBSITE  := https://github.com/libjxl/libjxl
$(PKG)_DESCR    := JPEG XL image format reference implementation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6
$(PKG)_CHECKSUM := 89584e20c6e537d8d65d286fd6ae48d5d6abb087ca89f3207238d8d7e6ced4dc
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjxl-[0-9]*.patch)))
$(PKG)_GH_CONF  := libjxl/libjxl/tags,v
$(PKG)_DEPS     := cc brotli highway lcms libjpeg-turbo libpng

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DJPEGXL_STATIC=$(CMAKE_STATIC_BOOL) \
        -DBUILD_TESTING=OFF \
        -DJPEGXL_ENABLE_TOOLS=OFF \
        -DJPEGXL_ENABLE_BENCHMARK=OFF \
        -DJPEGXL_ENABLE_EXAMPLES=OFF \
        -DJPEGXL_ENABLE_SJPEG=OFF \
        -DJPEGXL_ENABLE_LODEPNG=OFF \
        -DJPEGXL_ENABLE_OPENEXR=OFF \
        -DJPEGXL_ENABLE_SKCMS=OFF \
        -DJPEGXL_FORCE_SYSTEM_BROTLI=ON \
        -DJPEGXL_FORCE_SYSTEM_HWY=ON \
        -DJPEGXL_FORCE_SYSTEM_LCMS=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
