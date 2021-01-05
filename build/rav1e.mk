PKG             := rav1e
$(PKG)_WEBSITE  := https://github.com/xiph/rav1e
$(PKG)_DESCR    := The fastest and safest AV1 encoder
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4.0
$(PKG)_CHECKSUM := c3ea1a2275f09c8a8964084c094d81f01c07fb405930633164ba69d0613a9003
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := xiph/rav1e/tags,v
$(PKG)_DEPS     := cc rust $(BUILD)~nasm cargo-c

define $(PKG)_BUILD
    # Enable networking while we build rav1e
    $(eval export MXE_ENABLE_NETWORK := 1)

    # armv7 -> thumbv7a
    $(eval ARCH_NAME := $(if $(findstring armv7,$(PROCESSOR)),thumbv7a,$(PROCESSOR)))

    cd '$(SOURCE_DIR)' && $(if $(IS_ARM), CC='$(TARGET)-clang') $(TARGET)-cargo cbuild \
        --release \
        --prefix='$(PREFIX)/$(TARGET)' \
        --target='$(ARCH_NAME)-pc-windows-gnu' \
        --library-type=$(if $(BUILD_STATIC),staticlib,cdylib) \
        --dlltool='$(if $(IS_LLVM),$(PREFIX)/$(BUILD)/bin/llvm-dlltool,$(TARGET)-dlltool)'

    # Uncomment to build/install rav1e binary
    #$(TARGET)-cargo install --no-track --path='$(SOURCE_DIR)' --root='$(PREFIX)/$(TARGET)'
    cd '$(SOURCE_DIR)' && $(TARGET)-cargo cinstall \
        --release \
        --prefix='$(PREFIX)/$(TARGET)' \
        --target='$(ARCH_NAME)-pc-windows-gnu' \
        --library-type=$(if $(BUILD_STATIC),staticlib,cdylib)

    # Windows convention: import library is called "librav1e.dll.a"
    $(if $(BUILD_SHARED),
        mv -fv '$(PREFIX)/$(TARGET)/lib/rav1e.dll.a' '$(PREFIX)/$(TARGET)/lib/librav1e.dll.a')
endef
