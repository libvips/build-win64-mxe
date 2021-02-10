PKG             := vips-gmic
$(PKG)_WEBSITE  := https://github.com/jcupitt/vips-gmic
$(PKG)_DESCR    := libvips plugin for running gmic commands
$(PKG)_IGNORE   :=
# https://github.com/kleisauke/vips-gmic/tarball/a03dc3865e6fd486a9572c596be147fb0c52b1ae
$(PKG)_VERSION  := a03dc38
$(PKG)_CHECKSUM := 1f551e8f5ee35fdc0606f3cccee108294e3ad4f6dd5c5af6a6b04c62b60c9e12
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-gmic-[0-9]*.patch)))
$(PKG)_GH_CONF  := kleisauke/vips-gmic/branches/master
$(PKG)_DEPS     := vips-web

define $(PKG)_BUILD
    # Enable networking while we build vips-gmic
    echo 'static int __attribute__((unused)) _dummy;' > '$(BUILD_DIR)/dummy.c'
    $(BUILD_CC) -shared -fPIC $(NONET_CFLAGS) -o $(NONET_LIB) '$(BUILD_DIR)/dummy.c'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 plugin-install

    # Disable networking (again) for reproducible builds further on
    $(BUILD_CC) -shared -fPIC $(NONET_CFLAGS) -o $(NONET_LIB) '$(TOP_DIR)/tools/nonetwork.c'
endef
