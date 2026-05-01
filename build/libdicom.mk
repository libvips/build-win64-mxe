PKG             := libdicom
$(PKG)_WEBSITE  := https://github.com/ImagingDataCommons/libdicom
$(PKG)_DESCR    := C library for reading DICOM files.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.1
$(PKG)_CHECKSUM := 7a448d295b179a4c0b311c09f5253655446a44bf66b3b7d2aa4c09d15f02f1f8
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := ImagingDataCommons/libdicom/releases,v,,,,.tar.xz
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    # Enable networking to allow uthash to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 $(MXE_MESON_WRAPPER) \
        -Dtests=false \
        --force-fallback-for=uthash \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
