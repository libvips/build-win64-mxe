PKG             := directx-headers
$(PKG)_WEBSITE  := https://github.com/microsoft/DirectX-Headers
$(PKG)_DESCR    := Official DirectX headers available under an open source license
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.619.1
$(PKG)_CHECKSUM := 6193774904c940eebb9b0c51b816b93dd776cfeb25a951f0f4a58f22387e5008
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
