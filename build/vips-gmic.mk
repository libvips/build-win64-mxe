PKG             := vips-gmic
$(PKG)_WEBSITE  := https://github.com/jcupitt/vips-gmic
$(PKG)_DESCR    := libvips plugin for running gmic commands
$(PKG)_IGNORE   :=
# https://github.com/kleisauke/vips-gmic/tarball/bb874638c24e2632d9cffa28f66d47da84f28ae8
$(PKG)_VERSION  := bb87463
$(PKG)_CHECKSUM := 345251e2c744393c61e8a6dc314bcf515006badb3d6744a1317cc3940bd7e325
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-gmic-[0-9]*.patch)))
$(PKG)_GH_CONF  := kleisauke/vips-gmic/branches/master
$(PKG)_DEPS     := vips-all

define $(PKG)_BUILD
    # Enable networking while we build vips-gmic
    $(eval export MXE_ENABLE_NETWORK := 1)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 plugin-install
endef
