PKG             := zlib-ng
$(PKG)_WEBSITE  := https://github.com/zlib-ng/zlib-ng
$(PKG)_DESCR    := zlib replacement with optimizations for "next generation" systems.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.6
$(PKG)_CHECKSUM := a5d504c0d52e2e2721e7e7d86988dec2e290d723ced2307145dedd06aeb6fef2
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := zlib-ng/zlib-ng/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)

    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_COMPAT=ON \
        -DZLIB_ENABLE_TESTS=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
