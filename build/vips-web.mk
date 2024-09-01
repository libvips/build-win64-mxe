PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
# https://github.com/libvips/libvips/tarball/26f148fbccb927e1e7d85ad36d45995b35138101
$(PKG)_VERSION  := 26f148f
$(PKG)_CHECKSUM := 4c1030dd9f78ea0d21ce0766d57163e6b0c9491d849135f9733ada05894a6301
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := libvips/libvips/branches/8.15
$(PKG)_DEPS     := cc meson-wrapper libwebp librsvg glib pango libarchive \
                   libjpeg-turbo tiff lcms libexif libheif libpng \
                   libspng libimagequant highway cgif

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(PREFIX)/$(TARGET)/vips-packaging
    $(foreach f, ChangeLog LICENSE README.md, \
        cp '$(SOURCE_DIR)/$(f)' '$(PREFIX)/$(TARGET)/vips-packaging';)

    (printf '{\n'; \
     printf '  "aom": "$(aom_VERSION)",\n'; \
     printf '  "archive": "$(libarchive_VERSION)",\n'; \
     printf '  "cairo": "$(cairo_VERSION)",\n'; \
     printf '  "cgif": "$(cgif_VERSION)",\n'; \
     printf '  "exif": "$(libexif_VERSION)",\n'; \
     printf '  "expat": "$(expat_VERSION)",\n'; \
     printf '  "ffi": "$(libffi_VERSION)",\n'; \
     printf '  "fontconfig": "$(fontconfig_VERSION)",\n'; \
     printf '  "freetype": "$(freetype_VERSION)",\n'; \
     printf '  "fribidi": "$(fribidi_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),,printf '  "gettext": "$(gettext_VERSION)"$(comma)\n';) \
     printf '  "glib": "$(glib_VERSION)",\n'; \
     printf '  "harfbuzz": "$(harfbuzz_VERSION)",\n'; \
     printf '  "heif": "$(libheif_VERSION)",\n'; \
     printf '  "highway": "$(highway_VERSION)",\n'; \
     printf '  "imagequant": "$(libimagequant_VERSION)",\n'; \
     $(if $(IS_JPEGLI), \
          printf '  "jpegli": "$(jpegli_VERSION)"$(comma)\n';, \
          $(if $(IS_MOZJPEG),,printf '  "jpeg": "$(libjpeg-turbo_VERSION)"$(comma)\n';)) \
     printf '  "lcms": "$(lcms_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),printf '  "mozjpeg": "$(mozjpeg_VERSION)"$(comma)\n';) \
     printf '  "pango": "$(pango_VERSION)",\n'; \
     printf '  "pixman": "$(pixman_VERSION)",\n'; \
     printf '  "png": "$(libpng_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),printf '  "proxy-libintl": "$(proxy-libintl_VERSION)"$(comma)\n';) \
     printf '  "rsvg": "$(librsvg_VERSION)",\n'; \
     printf '  "spng": "$(libspng_VERSION)",\n'; \
     printf '  "tiff": "$(tiff_VERSION)",\n'; \
     printf '  "vips": "$(vips-web_VERSION)",\n'; \
     printf '  "webp": "$(libwebp_VERSION)",\n'; \
     printf '  "xml": "$(libxml2_VERSION)",\n'; \
     $(if $(IS_ZLIB_NG), \
          printf '  "zlib-ng": "$(zlib-ng_VERSION)"\n';, \
          printf '  "zlib": "$(zlib_VERSION)"\n';) \
     printf '}';) \
     > '$(PREFIX)/$(TARGET)/vips-packaging/versions.json'
endef

define $(PKG)_BUILD
    $($(PKG)_PRE_CONFIGURE)

    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    # Always build as shared library, we need
    # libvips-42.dll for the language bindings.
    $(MXE_MESON_WRAPPER) \
        --default-library=shared \
        -Ddeprecated=false \
        -Dexamples=false \
        -Dintrospection=disabled \
        -Dmodules=disabled \
        -Dcfitsio=disabled \
        -Dfftw=disabled \
        -Djpeg-xl=disabled \
        -Dmagick=disabled \
        -Dmatio=disabled \
        -Dnifti=disabled \
        -Dopenexr=disabled \
        -Dopenjpeg=disabled \
        -Dopenslide=disabled \
        -Dpdfium=disabled \
        -Dpoppler=disabled \
        -Dquantizr=disabled \
        -Dppm=false \
        -Danalyze=false \
        -Dradiance=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
