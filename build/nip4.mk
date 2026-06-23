PKG             := nip4
$(PKG)_WEBSITE  := https://github.com/libvips/nip4
$(PKG)_DESCR    := Image processing spreadsheet
$(PKG)_IGNORE   :=
# https://github.com/libvips/nip4/tarball/960b27d015ebbc9e73a4e70a8aba87ac09c5fa1f
$(PKG)_VERSION  := 960b27d
$(PKG)_CHECKSUM := d8c9c6d9b8ca0282bf339a9d31b8946f1f52d1e6ea195c146bbfd9d931833325
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/nip4/branches/main
$(PKG)_DEPS     := cc meson-wrapper gtk4 adwaita-icon-theme gsl vips-all

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "adwaita-icon-theme": "$(adwaita-icon-theme_VERSION)",\n'; \
     printf '  "directx-headers": "$(directx-headers_VERSION)",\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
     printf '  "gdk-pixbuf": "$(gdk-pixbuf_VERSION)",\n'; \
     printf '  "graphene": "$(graphene_VERSION)",\n'; \
     printf '  "gsl": "$(gsl_VERSION)",\n'; \
     printf '  "gtk": "$(gtk4_VERSION)",\n'; \
     printf '  "nip4": "$(nip4_VERSION)"\n'; \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions-nip4.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(eval export CFLAGS += -O3)

    # Increase the stack size to 16MiB, as 1MiB is too small for nip4
    $(eval export LDFLAGS += -Wl,--stack,16777216)

    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
