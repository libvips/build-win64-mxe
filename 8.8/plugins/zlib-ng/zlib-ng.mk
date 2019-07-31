PKG             := zlib-ng
$(PKG)_WEBSITE  := https://github.com/zlib-ng/zlib-ng
$(PKG)_DESCR    := zlib replacement with optimizations for "next generation" systems.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := f06c71f
$(PKG)_CHECKSUM := 94bdc4b3df698313adcadfa38bc13756d2f0ff38f5f5a663cc4446f7f97c49cb
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-ng-[0-9]*.patch)))
$(PKG)_GH_CONF  := zlib-ng/zlib-ng/branches/develop
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_COMPAT=ON \
        -DZLIB_ENABLE_TESTS=OFF \
        -DINSTALL_PKGCONFIG_DIR='$(PREFIX)/$(TARGET)/lib/pkgconfig' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
