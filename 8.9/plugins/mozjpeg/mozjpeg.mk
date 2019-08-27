PKG             := mozjpeg
$(PKG)_WEBSITE  := https://github.com/mozilla/mozjpeg
$(PKG)_DESCR    := A JPEG codec that provides increased compression for JPEG images (at the expense of compression performance).
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 68564c0
$(PKG)_CHECKSUM := 903c8259590e8110133612498827e221468f6f5e7ee380531d1505dbd478aee8
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mozjpeg-[0-9]*.patch)))
$(PKG)_GH_CONF  := mozilla/mozjpeg/branches/master
$(PKG)_DEPS     := cc yasm

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the 
# libjpeg API)
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DWITH_TURBOJPEG=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER=$(TARGET)-yasm
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
