PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.8.0
$(PKG)_CHECKSUM := e43ef91a5ad41de4471a2fd484279d0793b419009a7d102965739da8f7b75d96
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/releases,v
$(PKG)_DEPS     := cc aom libde265 x265

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        $(if $(IS_LLVM),,-DCMAKE_CXX_FLAGS='-Wno-error=maybe-uninitialized')

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
