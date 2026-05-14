PKG             := uhdr
$(PKG)_WEBSITE  := https://github.com/google/libultrahdr
$(PKG)_DESCR    := Library for encoding and decoding ultrahdr images
$(PKG)_IGNORE   :=
# https://github.com/google/libultrahdr/tarball/82b4f6da9f4db25f51a3a40201ab6eb86b6d6bb7
$(PKG)_VERSION  := 82b4f6d
$(PKG)_CHECKSUM := 74ef40ac42ca3078e75909d75eab8215c3219078580d8db95fa5e01d23aa4227
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := google/libultrahdr/branches/main
$(PKG)_DEPS     := cc libjpeg-turbo

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    # Ensure install targets are enabled when cross-compiling
    $(SED) -i 's/CMAKE_CROSSCOMPILING AND UHDR_ENABLE_INSTALL/FALSE/' '$(SOURCE_DIR)/CMakeLists.txt'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DUHDR_BUILD_EXAMPLES=FALSE \
        -DUHDR_MAX_DIMENSION=65500 \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
