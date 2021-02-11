PKG             := vips-gmic
$(PKG)_WEBSITE  := https://github.com/jcupitt/vips-gmic
$(PKG)_DESCR    := libvips plugin for running gmic commands
$(PKG)_IGNORE   :=
# https://github.com/kleisauke/vips-gmic/tarball/6ce4541164d9fb19f0b03ba2a54503338b06a043
$(PKG)_VERSION  := 6ce4541
$(PKG)_CHECKSUM := 27ae2d52c881c71e0d9464c308ace49b3df84e7f5a9d438e42b97bdf73e949cb
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
