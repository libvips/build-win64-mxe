PKG             := zlib-ng
$(PKG)_WEBSITE  := https://github.com/zlib-ng/zlib-ng
$(PKG)_DESCR    := zlib replacement with optimizations for "next generation" systems.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.6
$(PKG)_CHECKSUM := 8258b75a72303b661a238047cb348203d88d9dddf85d480ed885f375916fcab6
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := zlib-ng/zlib-ng/tags
$(PKG)_DEPS     := cc

# ACLE intrinsics are unavailable on armv7
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_COMPAT=ON \
        -DZLIB_ENABLE_TESTS=OFF \
        $(if $(call seq,armv7,$(PROCESSOR)), -DWITH_ACLE=OFF) \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
