PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := Official DirectX headers available under an open source license
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.618.2
$(PKG)_CHECKSUM := 62004f45e2ab00cbb5c7f03c47262632c22fbce0a237383fc458d9324c44cf36
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := microsoft/DirectX-Headers/tags,v
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dbuild-test=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
