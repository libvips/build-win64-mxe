PKG             := vipsdisp
$(PKG)_WEBSITE  := https://github.com/jcupitt/vipsdisp
$(PKG)_DESCR    := Tiny libvips / gtk+4 image viewer
$(PKG)_IGNORE   :=
# https://github.com/jcupitt/vipsdisp/tarball/5638e7018bc41102abed0fac059e56960c6f3d60
$(PKG)_VERSION  := 5638e70
$(PKG)_CHECKSUM := 65ba9ba6448b105489132ed4b53cfa11efd3f3ab0f8018adb86b716d1d9d7f31
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := jcupitt/vipsdisp/branches/master
$(PKG)_DEPS     := cc meson-wrapper gtk4 $(foreach TARGET,$(MXE_TARGETS),vips-$(lastword $(call split,.,$(TARGET))))

define $(PKG)_PRE_CONFIGURE
    (printf '{\n'; \
     printf '  "epoxy": "$(libepoxy_VERSION)",\n'; \
     printf '  "graphene": "$(graphene_VERSION)",\n'; \
     printf '  "gtk": "$(gtk4_VERSION)",\n'; \
     printf '  "vipsdisp": "$(vipsdisp_VERSION)",\n'; \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions-disp.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(eval export CFLAGS += -O3)

    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
