PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Performance-portable, length-agnostic SIMD with runtime dispatch
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.15.0
$(PKG)_CHECKSUM := 4bbd4439eae08cf038f1c5cc5d9ebc6a1a50f2c610c13a1483adccacfa24c150
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/highway-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/highway/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_TESTING=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
