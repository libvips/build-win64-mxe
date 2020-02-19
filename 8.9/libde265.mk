PKG             := libde265
$(PKG)_WEBSITE  := https://www.libde265.org/
$(PKG)_DESCR    := Open h.265 video codec implementation.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.5
$(PKG)_CHECKSUM := e3f277d8903408615a5cc34718b391b83c97c646faea4f41da93bac5ee08a87f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libde265/releases,v
$(PKG)_DEPS     := cc mingw-std-threads

define $(PKG)_BUILD
    $(if $(findstring win32,$(TARGET)),\
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(libde265_PATCHES))))/libde265-mingw-std-threads.patch)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        $(if $(findstring win32,$(TARGET)), \
            -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -I$(PREFIX)/$(TARGET)/include/mingw-std-threads') \
        -DDISABLE_SIMD=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
