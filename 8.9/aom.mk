PKG             := aom
$(PKG)_WEBSITE  := https://aomedia.googlesource.com/aom/
$(PKG)_DESCR    := AV1 Codec Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0.0
$(PKG)_CHECKSUM := 3567ebe767e469f13bb25a334b964acb20ff79dd26510a4e7367e0ab0c289898
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
# We use a local mirror from FreeBSD because
# downloading from googlesource is not reliable.
$(PKG)_GH_CONF  := jbeich/aom/tags,v
# $(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
# $(PKG)_URL      := https://aomedia.googlesource.com/aom/+archive/v$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc $(BUILD)~nasm

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && NASM_PATH='$(PREFIX)/$(BUILD)/bin' $(TARGET)-cmake \
        -DENABLE_NASM=ON \
        -DENABLE_TESTS=OFF \
        -DCONFIG_RUNTIME_CPU_DETECT=0 \
        '$(SOURCE_DIR)'

    # parallel build sometimes doesn't work; fallback to -j 1.
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' || $(MAKE) -C '$(BUILD_DIR)' -j 1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
