PKG             := highway
$(PKG)_WEBSITE  := https://github.com/google/highway
$(PKG)_DESCR    := Performance-portable, length-agnostic SIMD with runtime dispatch
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.5
$(PKG)_CHECKSUM := 99b7dad98b8fa088673b720151458fae698ae5df9154016e39de4afdc23bb927
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/highway/tags
$(PKG)_DEPS     := cc

# Highway requires VFPv4 floating-point instructions when targeting Armv7.
# See: https://github.com/google/highway/pull/1143
# Dynamic dispatch requires Linux to detect CPU capabilities on both Armv7
# and AArch64.
define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_TESTING=OFF \
        -DHWY_ENABLE_CONTRIB=OFF \
        -DHWY_ENABLE_EXAMPLES=OFF \
        $(if $(call seq,armv7,$(PROCESSOR)), -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -mfpu=neon-vfpv4') \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
