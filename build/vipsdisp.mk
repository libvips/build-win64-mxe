PKG             := vipsdisp
$(PKG)_WEBSITE  := https://github.com/jcupitt/vipsdisp
$(PKG)_DESCR    := Tiny libvips / gtk+4 image viewer
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.1.1-test-gtk-svg-load
$(PKG)_CHECKSUM := 90005b2c9cad3a45ad5b847fe72eac799579c4bc073cf471e14ef3c4d7a6d780
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/vipsdisp/releases,v,,,,-test-gtk4-svg.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(firstword $(subst -, ,$($(PKG)_VERSION)))
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-test-gtk4-svg.tar.xz
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
