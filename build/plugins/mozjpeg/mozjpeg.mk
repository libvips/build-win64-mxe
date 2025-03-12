PKG             := mozjpeg
$(PKG)_WEBSITE  := https://github.com/mozilla/mozjpeg
$(PKG)_DESCR    := A JPEG codec that provides increased compression for JPEG images (libjpeg-turbo fork).
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.5
$(PKG)_CHECKSUM := 9fcbb7171f6ac383f5b391175d6fb3acde5e64c4c4727274eade84ed0998fcc1
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := mozilla/mozjpeg/tags,v
$(PKG)_DEPS     := cc $(BUILD)~nasm

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the
# libjpeg API)
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DWITH_TURBOJPEG=OFF \
        -DPNG_SUPPORTED=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER='$(PREFIX)/$(BUILD)/bin/nasm' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
