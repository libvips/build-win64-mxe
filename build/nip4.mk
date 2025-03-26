PKG             := nip4
$(PKG)_WEBSITE  := https://github.com/jcupitt/nip4
$(PKG)_DESCR    := Image processing spreadsheet
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.5
$(PKG)_CHECKSUM := 4a02558d0d29760effe8cdffa1ef7234a3dfdd05cc00be0f0314dfd6d35bbfe4
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/nip4/releases,v,,,,.tar.xz
$(PKG)_DEPS     := cc meson-wrapper gtk4 gsl vips-all

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
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
