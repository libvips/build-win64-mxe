PKG             := libde265
$(PKG)_WEBSITE  := https://www.libde265.org/
$(PKG)_DESCR    := Open h.265 video codec implementation.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.3
$(PKG)_CHECKSUM := 554228bd17788c99a7e63b37ab5634722190e6e2bf60c1dcb01cef328e133905
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libde265/releases,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # Disable dec265.exe with -DENABLE_DECODER=OFF
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DENABLE_DECODER=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
