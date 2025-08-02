PKG             := vipsdisp
$(PKG)_WEBSITE  := https://github.com/jcupitt/vipsdisp
$(PKG)_DESCR    := Tiny libvips / gtk+4 image viewer
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.1-windows-icon
$(PKG)_CHECKSUM := 53db607dfb9d61c904514c4f64a7d5a5d856a451ba603b584868aea03c8a31f0
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/vipsdisp/releases,v,,,,-windows-icon4.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(firstword $(subst -, ,$($(PKG)_VERSION)))
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_DEPS     := cc meson-wrapper gtk4 adwaita-icon-theme vips-all 

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "adwaita-icon-theme": "$(adwaita-icon-theme_VERSION)",\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
     printf '  "graphene": "$(graphene_VERSION)",\n'; \
     printf '  "gtk": "$(gtk4_VERSION)",\n'; \
     printf '  "vipsdisp": "$(vipsdisp_VERSION)"\n'; \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions-vipsdisp.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(eval export CFLAGS += -O3)

    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
