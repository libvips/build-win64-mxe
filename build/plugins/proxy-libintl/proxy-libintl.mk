PKG             := proxy-libintl
$(PKG)_WEBSITE  := https://github.com/frida/proxy-libintl
$(PKG)_DESCR    := Proxy for a dynamically loaded optional libintl.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.4
$(PKG)_CHECKSUM := 13ef3eea0a3bc0df55293be368dfbcff5a8dd5f4759280f28e030d1494a5dffb
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
