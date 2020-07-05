PKG             := libde265
$(PKG)_WEBSITE  := https://www.libde265.org/
$(PKG)_DESCR    := Open h.265 video codec implementation.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.4
$(PKG)_CHECKSUM := c3f033bd59777624859c8d04a5b7ce4210adbce4a500943d2e211c4d517d0116
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libde265/releases,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_C_FLAGS="-msse4.1" \
        -DCMAKE_CXX_FLAGS="-msse4.1" \
        -DDISABLE_SSE=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
