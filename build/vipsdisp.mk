PKG             := vipsdisp
$(PKG)_WEBSITE  := https://github.com/libvips/vipsdisp
$(PKG)_DESCR    := Tiny libvips / gtk+4 image viewer
$(PKG)_IGNORE   :=
# https://github.com/libvips/vipsdisp/tarball/f7f5994b563bcd413bd60861e938f145138fe9d3
$(PKG)_VERSION  := f7f5994
$(PKG)_CHECKSUM := 6314b1206bc062049df12c54dacf0eee39ea2d7fe3ada3d2d21e544c333d8af7
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/vipsdisp/branches/master
$(PKG)_DEPS     := cc meson-wrapper gtk4 adwaita-icon-theme vips-all

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "adwaita-icon-theme": "$(adwaita-icon-theme_VERSION)",\n'; \
     printf '  "directx-headers": "$(directx-headers_VERSION)",\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
     printf '  "gdk-pixbuf": "$(gdk-pixbuf_VERSION)",\n'; \
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
