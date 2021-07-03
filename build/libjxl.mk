PKG             := libjxl
$(PKG)_WEBSITE  := https://github.com/libjxl/libjxl
$(PKG)_DESCR    := JPEG XL image format reference implementation
$(PKG)_IGNORE   :=
# https://github.com/libjxl/libjxl/tarball/c8b0bf3789351c9ccd8c48441354c522fd9ab188
$(PKG)_VERSION  := c8b0bf3
$(PKG)_CHECKSUM := 7f9ee9d54a3a2bbf753680aac67ce49a316d062ffb072958232cfdbf0ff78fdc
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjxl-[0-9]*.patch)))
$(PKG)_GH_CONF  := libjxl/libjxl/branches/main
$(PKG)_DEPS     := cc brotli highway lcms libjpeg-turbo libpng

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DJPEGXL_STATIC=$(CMAKE_STATIC_BOOL) \
        -DBUILD_TESTING=OFF \
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
