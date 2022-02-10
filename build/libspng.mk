PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
# https://github.com/randy408/libspng/tarball/4baa1b1384da4ae9ddbe42a90e5f6300afb44fe7
$(PKG)_VERSION  := 4baa1b1
$(PKG)_CHECKSUM := e103bafb4e40e93fe2bed3ed83aa471c9a11429737b067e2b7210b8ed3601577
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := randy408/libspng/branches/master
$(PKG)_DEPS     := cc zlib

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        -Dbuild_examples=false \
        -Dstatic_zlib=$(if $(BUILD_STATIC),true,false) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
