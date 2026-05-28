PKG             := gtk4
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GTK4
$(PKG)_IGNORE   :=
# https://gitlab.gnome.org/GNOME/gtk/-/archive/7556498/gtk-7556498.tar.gz
$(PKG)_VERSION  := 7556498
$(PKG)_CHECKSUM := 3d53fd2ae832a2788588c6e565ba847db62c6c8416c583e8b950dd72dc259703
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gtk-[0-9]*.patch)))
$(PKG)_SUBDIR   := gtk-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://gitlab.gnome.org/GNOME/gtk/-/archive/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper glib gdk-pixbuf pango fontconfig cairo libepoxy graphene directx-headers

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
