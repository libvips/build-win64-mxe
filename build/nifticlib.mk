PKG             := nifticlib
$(PKG)_WEBSITE  := https://github.com/NIFTI-Imaging/nifti_clib
$(PKG)_DESCR    := A set of i/o libraries for reading and writing files in the nifti-1 data format
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.0
$(PKG)_CHECKSUM := fe6cb1076974df01844f3f4dab1aa844953b3bc1d679126c652975158573d03d
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := NIFTI-Imaging/nifti_clib/tags,v
$(PKG)_DEPS     := cc zlib

# build without NIFTI-2 support, as that's still experimental
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DUSE_NIFTI2_CODE=OFF \
        -DNIFTI_BUILD_TESTING=OFF \
        -DNIFTI_INSTALL_NO_DOCS=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))

    # create pkg-config files
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Libs: -lniftiio -lnifticdf -lznz';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/$(PKG).pc'
endef
