PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := Official DirectX headers available under an open source license
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.619.5
$(PKG)_CHECKSUM := 24a0b7d8079a2dbbc90753c0d8bc812040d052acce2302e69a97c5d873b313b8
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
