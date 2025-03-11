PKG             := nip4
$(PKG)_WEBSITE  := https://github.com/jcupitt/nip4
$(PKG)_DESCR    := Image processing spreadsheet
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.2-2
$(PKG)_CHECKSUM := 3f33e839e2ab003528c7f315006a80ba49389d0131e798193e3e00234768d8d1
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/nip4/releases,v,,,,.tar.xz
$(PKG)_DEPS     := cc meson-wrapper gtk4 gsl $(foreach TARGET,$(MXE_TARGETS),vips-$(lastword $(call split,.,$(TARGET))))

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
     printf '  "graphene": "$(graphene_VERSION)",\n'; \
     printf '  "gtk": "$(gtk4_VERSION)",\n'; \
     printf '  "gsl": "$(gsl_VERSION)",\n'; \
     printf '  "nip4": "$(nip4_VERSION)",\n'; \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions-nip4.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(eval export CFLAGS += -O3)

    # set the stack size to 16mb ... default is 1mb, which is too small for
    # nip4
    $(eval export CFLAGS += -Wl,--stack,16777216)

    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
