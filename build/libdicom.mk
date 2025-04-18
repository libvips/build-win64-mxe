PKG             := libdicom
$(PKG)_WEBSITE  := https://github.com/ImagingDataCommons/libdicom
$(PKG)_DESCR    := C library for reading DICOM files.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.0
$(PKG)_CHECKSUM := 3b8c05ceb6bf667fed997f23b476dd32c3dc6380eee1998185c211d86a7b4918
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
