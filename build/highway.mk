PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Performance-portable, length-agnostic SIMD with runtime dispatch
$(PKG)_IGNORE   :=
# https://github.com/google/highway/tarball/36c56ab76ac3c7cf57635d23228706669e8e48b0
$(PKG)_VERSION  := 36c56ab
$(PKG)_CHECKSUM := afecc08a39ed43333aed3bf1caef6d1dbc0b71c53ad13e4ee88b314d9d081b62
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
