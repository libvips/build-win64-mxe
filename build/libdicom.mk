PKG             := libdicom
$(PKG)_WEBSITE  := https://github.com/ImagingDataCommons/libdicom
$(PKG)_DESCR    := C library for reading DICOM files.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.0
$(PKG)_CHECKSUM := 058bfaa7653c60a70798e021001d765e3f91ca4df5a8824b7604eaa57376449b
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
