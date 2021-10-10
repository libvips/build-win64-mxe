PKG             := proxy-libintl
$(PKG)_WEBSITE  := https://github.com/frida/proxy-libintl
$(PKG)_DESCR    := Proxy for a dynamically loaded optional libintl.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.2
$(PKG)_CHECKSUM := 2395a40f18fd7ecd199e2a9b9cbfff1ad8f9823bdfd5766a0445bbe5b5102448
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := frida/proxy-libintl/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        --default-library=static \
        -Dc_args='-DG_INTL_STATIC_COMPILATION' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
