PKG             := aom
$(PKG)_WEBSITE  := https://aomedia.googlesource.com/aom/
$(PKG)_DESCR    := AV1 Codec Library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.10.0
$(PKG)_CHECKSUM := 55ccb6816fb4b7d508d96a95b6e9cc3d2c0ae047f9f947dbba03720b56d89631
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := libaom-$($(PKG)_VERSION)
$(PKG)_FILE     := libaom-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://storage.googleapis.com/aom-releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc $(BUILD)~nasm

define $(PKG)_BUILD
    # When targeting Armv7 we need to build without `-gcodeview`:
    # `fatal error: error in backend: unknown codeview register D11_D12`
    # FIXME(kleisauke): https://github.com/llvm/llvm-project/issues/64278
    cd '$(BUILD_DIR)' && NASM_PATH='$(PREFIX)/$(BUILD)/bin' $(TARGET)-cmake \
        -DENABLE_NASM=ON \
        -DENABLE_DOCS=OFF \
        -DENABLE_TESTS=OFF \
        -DENABLE_TESTDATA=OFF \
        -DENABLE_TOOLS=OFF \
        -DENABLE_EXAMPLES=OFF \
        -DCONFIG_AV1_HIGHBITDEPTH=0 \
        -DCONFIG_WEBM_IO=0 \
        $(if $(IS_ARM), -DCONFIG_RUNTIME_CPU_DETECT=0) \
        $(if $(call seq,i686,$(PROCESSOR)), -DAOM_TARGET_CPU='x86') \
        $(if $(call seq,armv7,$(PROCESSOR)), -DCMAKE_C_FLAGS='') \
        '$(SOURCE_DIR)'

    # parallel build sometimes doesn't work; fallback to -j 1.
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' || $(MAKE) -C '$(BUILD_DIR)' -j 1
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
