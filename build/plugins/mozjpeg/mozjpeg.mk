PKG             := mozjpeg
$(PKG)_WEBSITE  := https://github.com/mozilla/mozjpeg
$(PKG)_DESCR    := A JPEG codec that provides increased compression for JPEG images (at the expense of compression performance).
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 6d95c51
$(PKG)_CHECKSUM := f8788ccc5a8fe3068b5cb72d620ecdf67d358324640e18095f36a05fdfee5ae6
# Avoid duplicated patches
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/libjpeg-turbo-[0-9]*.patch)))
$(PKG)_GH_CONF  := mozilla/mozjpeg/branches/master
$(PKG)_DEPS     := cc $(BUILD)~nasm

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the 
# libjpeg API)
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DWITH_TURBOJPEG=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER='$(PREFIX)/$(BUILD)/bin/nasm' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
