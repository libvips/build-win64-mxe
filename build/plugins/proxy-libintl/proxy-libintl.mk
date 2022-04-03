PKG             := proxy-libintl
$(PKG)_WEBSITE  := https://github.com/frida/proxy-libintl
$(PKG)_DESCR    := Proxy for a dynamically loaded optional libintl.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.3
$(PKG)_CHECKSUM := db1649fc97ddd686b1a4d4fe6a26775ff7a91ffd317ce700d027d19de73a7e04
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := frida/proxy-libintl/tags
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        --default-library=static \
        -Dc_args='$(CFLAGS) -DG_INTL_STATIC_COMPILATION' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
