PKG             := libde265
$(PKG)_WEBSITE  := https://www.libde265.org/
$(PKG)_DESCR    := Open h.265 video codec implementation.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.9
$(PKG)_CHECKSUM := 29bc6b64bf658d81a4446a3f98e0e4636fd4fd3d971b072d440cef987d5439de
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libde265/releases,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(if $(WIN32_THREADS), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(libde265_PATCHES))))/libde265-mingw-std-threads.patch)

    # Disable tools
    $(SED) -i "/add_subdirectory (dec265)/{N;d;}" '$(SOURCE_DIR)/CMakeLists.txt'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        $(if $(WIN32_THREADS), \
            -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -I$(PREFIX)/$(TARGET)/include/mingw-std-threads') \
        $(if $(IS_ARM), -DDISABLE_SSE=ON)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
