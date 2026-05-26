PKG             := aom
$(PKG)_WEBSITE  := https://aomedia.googlesource.com/aom/
$(PKG)_DESCR    := AV1 Codec Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.14.1
$(PKG)_CHECKSUM := 44bf90dbd23e734d50e70a8c41c285193922938bd0d3bc2ee56764d181d55ef5
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := libaom-$($(PKG)_VERSION)
$(PKG)_FILE     := libaom-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://storage.googleapis.com/aom-releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc $(BUILD)~nasm

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && NASM_PATH='$(PREFIX)/$(BUILD)/bin' $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DENABLE_NASM=ON \
        -DENABLE_DOCS=OFF \
        -DENABLE_TESTS=OFF \
        -DENABLE_TESTDATA=OFF \
        -DENABLE_TOOLS=OFF \
        -DENABLE_EXAMPLES=OFF \
        -DCONFIG_AV1_HIGHBITDEPTH=0 \
        -DCONFIG_WEBM_IO=0 \
        $(if $(call seq,i686,$(PROCESSOR)), -DAOM_TARGET_CPU='x86') \
        '$(SOURCE_DIR)'

    # parallel build sometimes doesn't work; fallback to -j 1.
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' || $(MAKE) -C '$(BUILD_DIR)' -j 1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
