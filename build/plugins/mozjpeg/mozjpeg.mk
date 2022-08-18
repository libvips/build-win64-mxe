PKG             := mozjpeg
$(PKG)_WEBSITE  := https://github.com/mozilla/mozjpeg
$(PKG)_DESCR    := A JPEG codec that provides increased compression for JPEG images (libjpeg-turbo fork).
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.1
$(PKG)_CHECKSUM := 66b1b8d6b55d263f35f27f55acaaa3234df2a401232de99b6d099e2bb0a9d196
# Avoid duplicated patches
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/../../patches/libjpeg-turbo-[0-9]*.patch)))
$(PKG)_GH_CONF  := mozilla/mozjpeg/tags,v
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
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
