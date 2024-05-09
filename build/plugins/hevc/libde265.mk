PKG             := libde265
$(PKG)_WEBSITE  := https://www.libde265.org/
$(PKG)_DESCR    := Open h.265 video codec implementation.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.15
$(PKG)_CHECKSUM := 00251986c29d34d3af7117ed05874950c875dd9292d016be29d3b3762666511d
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libde265/releases,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    # Disable tools with -DENABLE_{DE,EN}CODER=OFF
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DENABLE_DECODER=OFF \
        -DENABLE_ENCODER=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
