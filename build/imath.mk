PKG             := imath
$(PKG)_WEBSITE  := https://github.com/AcademySoftwareFoundation/Imath
$(PKG)_DESCR    := A C++ and python library of 2D and 3D vector, matrix, and math operations for computer graphics.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.1.6
$(PKG)_CHECKSUM := ea5592230f5ab917bea3ceab266cf38eb4aa4a523078d46eac0f5a89c52304db
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
