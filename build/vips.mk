PKG             := vips
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.19.0-rc2
$(PKG)_CHECKSUM := 9ea6e1bea194fd5f75027446594a38c3b0b84820862b6b2bd846eca9f1b28b14
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/releases,v,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(firstword $(subst -, ,$($(PKG)_VERSION)))
$(PKG)_DEPS     := cc meson-wrapper libwebp librsvg glib pango libarchive \
                   libjpeg-turbo tiff lcms libexif libheif \
                   libimagequant highway cgif uhdr

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    # Always build as shared library, we need
    # libvips-42.dll for the language bindings.
    $(MXE_MESON_WRAPPER) \
        --default-library=shared \
        -Dexamples=false \
        -Dman=false \
        $(if $(IS_INTL_DUMMY), -Dpo=false) \
        -Dtests=false \
        -Dintrospection=disabled \
        $(vips_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
