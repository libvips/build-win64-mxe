PKG             := gtk4
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GTK4
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4.18.3
$(PKG)_CHECKSUM := 081e1bc0b17db41a935af8d1f6f090fb1988936c42ff734d149f3d004119f8bb
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gtk-[0-9]*.patch)))
$(PKG)_SUBDIR   := gtk-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gtk/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper glib gdk-pixbuf pango fontconfig cairo libepoxy graphene

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
