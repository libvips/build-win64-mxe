PKG             := vipsdisp
$(PKG)_WEBSITE  := https://github.com/libvips/vipsdisp
$(PKG)_DESCR    := Tiny libvips / gtk+4 image viewer
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.2.0
$(PKG)_CHECKSUM := 20861ad42d8bda7af8290d475ca2dceaf01a8919ef4d67662c964a211740b746
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/vipsdisp/releases,v,,,,.tar.xz
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
