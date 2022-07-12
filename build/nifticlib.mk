PKG             := nifticlib
$(PKG)_WEBSITE  := https://github.com/NIFTI-Imaging/nifti_clib
$(PKG)_DESCR    := A set of i/o libraries for reading and writing files in the nifti-1 data format
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.1
$(PKG)_CHECKSUM := 868b611b5f8a3a73809436c9072db50db4975615905f0bd5fb7b1432e6d24b37
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := NIFTI-Imaging/nifti_clib/tags,v
$(PKG)_DEPS     := cc zlib

# build without NIFTI-2 support, as that's still experimental
# nifticdf library is not used by libvips, so don't build that either
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DUSE_NIFTI2_CODE=OFF \
        -DUSE_NIFTICDF_CODE=OFF \
        -DNIFTI_BUILD_TESTING=OFF \
        -DNIFTI_INSTALL_NO_DOCS=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
