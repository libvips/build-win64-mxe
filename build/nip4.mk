PKG             := nip4
$(PKG)_WEBSITE  := https://github.com/jcupitt/nip4
$(PKG)_DESCR    := Image processing spreadsheet
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.15
$(PKG)_CHECKSUM := 25145902a5ef15ca1519c37556e2fb80c88b5b639a8656abfac3e17a62fafa22
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/nip4/releases,v,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(firstword $(subst -, ,$($(PKG)_VERSION)))
$(PKG)_DEPS     := cc meson-wrapper gtk4 adwaita-icon-theme gsl vips-all

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "adwaita-icon-theme": "$(adwaita-icon-theme_VERSION)",\n'; \
     printf '  "directx-headers": "$(directx-headers_VERSION)",\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
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
