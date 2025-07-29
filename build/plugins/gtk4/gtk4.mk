PKG             := gtk4
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GTK4
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.19.2
$(PKG)_CHECKSUM := b1d4d44ceb0402ad31b85a0382d8249962cdd3ae1bf9bc2e1a2c9ee3e1ad5b67
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gtk-[0-9]*.patch)))
$(PKG)_SUBDIR   := gtk-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gtk/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper glib gdk-pixbuf pango fontconfig cairo libepoxy graphene librsvg directx-headers

define $(PKG)_BUILD
    # Disable tools
    $(SED) -i "/subdir('tools')/d" '$(SOURCE_DIR)/meson.build'

    $(MXE_MESON_WRAPPER) \
        -Dvulkan=disabled \
        -Dintrospection=disabled \
        -Dmedia-gstreamer=disabled \
        -Dbuild-testsuite=false \
        -Dbuild-examples=false \
        -Dbuild-tests=false \
        -Dbuild-demos=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
