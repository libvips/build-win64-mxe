PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Performance-portable, length-agnostic SIMD with runtime dispatch
$(PKG)_IGNORE   :=
# https://github.com/google/highway/tarball/91017e4f3bb7e3a178e3f2b1f393adea60a6df0d
$(PKG)_VERSION  := 91017e4
$(PKG)_CHECKSUM := c07f25290c3a6c660b5ebf9b2184c4353a643828a1b9f1d7390d40bc733eb274
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
