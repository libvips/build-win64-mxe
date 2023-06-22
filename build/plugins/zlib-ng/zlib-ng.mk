PKG             := zlib-ng
$(PKG)_WEBSITE  := https://github.com/zlib-ng/zlib-ng
$(PKG)_DESCR    := zlib replacement with optimizations for "next generation" systems.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.2
$(PKG)_CHECKSUM := 383560d6b00697c04e8878e26c0187b480971a8bce90ffd26a5a7b0f7ecf1a33
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := zlib-ng/zlib-ng/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_COMPAT=ON \
        -DZLIB_ENABLE_TESTS=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
