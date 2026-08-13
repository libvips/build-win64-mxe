PKG             := uhdr
$(PKG)_WEBSITE  := https://github.com/google/libultrahdr
$(PKG)_DESCR    := Library for encoding and decoding ultrahdr images
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.2
$(PKG)_CHECKSUM := aa8d193bb887c348c419780511dd03b374f4e07af8812b6d3f80c8537cf1ef2c
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/libultrahdr/tags,v
$(PKG)_DEPS     := cc libjpeg-turbo

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    # Ensure install targets are enabled when cross-compiling
    $(SED) -i 's/CMAKE_CROSSCOMPILING AND UHDR_ENABLE_INSTALL/FALSE/' '$(SOURCE_DIR)/CMakeLists.txt'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DUHDR_BUILD_EXAMPLES=FALSE \
        -DUHDR_ENABLE_HEIF=FALSE \
        -DUHDR_MAX_DIMENSION=65500 \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
