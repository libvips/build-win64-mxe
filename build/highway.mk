PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Performance-portable, length-agnostic SIMD with runtime dispatch
$(PKG)_IGNORE   :=
# https://github.com/google/highway/tarball/96ece0b038318964be63685b6f2100da716dd60d
$(PKG)_VERSION  := 96ece0b
$(PKG)_CHECKSUM := 36c7dd6ec3a5f9aadfb25918b8b7ffb475b720d7eec849147ab002d7a4fab3ce
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/highway-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/highway/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_TESTING=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
