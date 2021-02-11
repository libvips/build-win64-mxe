PKG             := vips-gmic
$(PKG)_WEBSITE  := https://github.com/jcupitt/vips-gmic
$(PKG)_DESCR    := libvips module for running gmic commands
$(PKG)_IGNORE   :=
# https://github.com/kleisauke/vips-gmic/tarball/76b648b384440d8e66b20315cd72073d638c61df
$(PKG)_VERSION  := 76b648b
$(PKG)_CHECKSUM := 40f6ad9a6220af6f3c707f4dfa55711f2d8687c685c00dd32dc771d942b0d1d6
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := kleisauke/vips-gmic/branches/master
$(PKG)_DEPS     := vips-all

define $(PKG)_BUILD
    # Enable networking while we build vips-gmic
    $(eval export MXE_ENABLE_NETWORK := 1)

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 module-install
endef
