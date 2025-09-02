PKG             := proxy-libintl
$(PKG)_WEBSITE  := https://github.com/frida/proxy-libintl
$(PKG)_DESCR    := Proxy for a dynamically loaded optional libintl.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.5
$(PKG)_CHECKSUM := f7a1cbd7579baaf575c66f9d99fb6295e9b0684a28b095967cfda17857595303
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := frida/proxy-libintl/tags
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        --default-library=static \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
