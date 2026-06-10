PKG             := uhdr
$(PKG)_WEBSITE  := https://github.com/google/libultrahdr
$(PKG)_DESCR    := Library for encoding and decoding ultrahdr images
$(PKG)_IGNORE   :=
# https://github.com/google/libultrahdr/tarball/13a058f452d846e43d4691f6885eeeaa8b0ea8d0
$(PKG)_VERSION  := 13a058f
$(PKG)_CHECKSUM := c910b8137e8ebff4a6f7d4bc579ea96549fee71984dea1a23a3effd266a29b1b
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
