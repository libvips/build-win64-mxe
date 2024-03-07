PKG             := libjxl
$(PKG)_WEBSITE  := https://github.com/libjxl/libjxl
$(PKG)_DESCR    := JPEG XL image format reference implementation
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.10.2
$(PKG)_CHECKSUM := 95e807f63143856dc4d161c071cca01115d2c6405b3d3209854ac6989dc6bb91
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libjxl/libjxl/tags,v
$(PKG)_DEPS     := cc brotli highway lcms libpng

define $(PKG)_BUILD
    # jpegli needs a couple of headers from libjpeg-turbo
    $(if $(IS_JPEGLI), \
        $(call PREPARE_PKG_SOURCE,libjpeg-turbo,$(BUILD_DIR)) \
        mv -v '$(BUILD_DIR)/$(libjpeg-turbo_SUBDIR)/'* '$(SOURCE_DIR)/third_party/libjpeg-turbo';)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_TESTING=OFF \
        -DJPEGXL_ENABLE_TOOLS=OFF \
        -DJPEGXL_ENABLE_DOXYGEN=OFF \
        -DJPEGXL_ENABLE_MANPAGES=OFF \
        -DJPEGXL_ENABLE_BENCHMARK=OFF \
        -DJPEGXL_ENABLE_EXAMPLES=OFF \
        -DJPEGXL_ENABLE_SJPEG=OFF \
        -DJPEGXL_ENABLE_OPENEXR=OFF \
        -DJPEGXL_ENABLE_SKCMS=OFF \
        -DJPEGXL_ENABLE_TRANSCODE_JPEG=OFF \
        -DJPEGXL_FORCE_SYSTEM_BROTLI=ON \
        -DJPEGXL_FORCE_SYSTEM_LCMS2=ON \
        -DJPEGXL_FORCE_SYSTEM_HWY=ON \
        $(if $(IS_JPEGLI), \
            -DJPEGXL_ENABLE_JPEGLI=ON \
            -DJPEGXL_INSTALL_JPEGLI_LIBJPEG=ON) \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
