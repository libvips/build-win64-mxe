PKG             := mozjpeg
$(PKG)_WEBSITE  := https://github.com/mozilla/mozjpeg
$(PKG)_DESCR    := A JPEG codec that provides increased compression for JPEG images (at the expense of compression performance).
$(PKG)_IGNORE   :=
# https://github.com/mozilla/mozjpeg/tarball/8fb32c0a3908b6202ea895c865a08b55bbb49bca
$(PKG)_VERSION  := 8fb32c0
$(PKG)_CHECKSUM := f63fcc321ee6c3216f4297ff226fdad73bf5e6f17415492f6f88a6602465f834
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
