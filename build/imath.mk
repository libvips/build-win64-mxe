PKG             := imath
$(PKG)_WEBSITE  := https://github.com/AcademySoftwareFoundation/Imath
$(PKG)_DESCR    := A C++ and python library of 2D and 3D vector, matrix, and math operations for computer graphics.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.4
$(PKG)_CHECKSUM := 3b5cef518964755963550b5f4a16e7c0a0872574921b1443f1d47fdb6b8c5afe
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := AcademySoftwareFoundation/Imath/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DIMATH_INSTALL_PKG_CONFIG=ON \
        -DBUILD_TESTING=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
