PKG             := vips-web
$(PKG)_WEBSITE  := https://libvips.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
# https://github.com/kleisauke/libvips/tarball/f047e7b0d08a15e0a11d6b48420e1477fe23683c
$(PKG)_VERSION  := f047e7b
$(PKG)_CHECKSUM := d99aefed89853200c012a586c59045eb0294519b27a0c38006b581f430f3bf2f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/vips-[0-9]*.patch)))
$(PKG)_GH_CONF  := kleisauke/libvips/branches/simd
$(PKG)_DEPS     := cc meson-wrapper libwebp librsvg glib pango libgsf \
                   libjpeg-turbo tiff lcms libexif libheif libpng \
                   libspng libimagequant cgif

define $(PKG)_PRE_CONFIGURE
    # Copy some files to the packaging directory
    mkdir -p $(PREFIX)/$(TARGET)/vips-packaging
    $(foreach f, ChangeLog LICENSE README.md, \
        cp '$(SOURCE_DIR)/$(f)' '$(PREFIX)/$(TARGET)/vips-packaging';)

    (printf '{\n'; \
     printf '  "aom": "$(aom_VERSION)",\n'; \
     printf '  "cairo": "$(cairo_VERSION)",\n'; \
     printf '  "cgif": "$(cgif_VERSION)",\n'; \
     printf '  "exif": "$(libexif_VERSION)",\n'; \
     printf '  "expat": "$(expat_VERSION)",\n'; \
     printf '  "ffi": "$(libffi_VERSION)",\n'; \
     printf '  "fontconfig": "$(fontconfig_VERSION)",\n'; \
     printf '  "freetype": "$(freetype_VERSION)",\n'; \
     printf '  "fribidi": "$(fribidi_VERSION)",\n'; \
     printf '  "gdkpixbuf": "$(gdk-pixbuf_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),,printf '  "gettext": "$(gettext_VERSION)"$(comma)\n';) \
     printf '  "glib": "$(glib_VERSION)",\n'; \
     printf '  "gsf": "$(libgsf_VERSION)",\n'; \
     printf '  "harfbuzz": "$(harfbuzz_VERSION)",\n'; \
     printf '  "heif": "$(libheif_VERSION)",\n'; \
     printf '  "imagequant": "$(libimagequant_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),,printf '  "jpeg": "$(libjpeg-turbo_VERSION)"$(comma)\n';) \
     printf '  "lcms": "$(lcms_VERSION)",\n'; \
     $(if $(IS_MOZJPEG),printf '  "mozjpeg": "$(mozjpeg_VERSION)"$(comma)\n';) \
     printf '  "pango": "$(pango_VERSION)",\n'; \
     printf '  "pixman": "$(pixman_VERSION)",\n'; \
     printf '  "png": "$(libpng_VERSION)",\n'; \
     $(if $(IS_INTL_DUMMY),printf '  "proxy-libintl": "$(proxy-libintl_VERSION)"$(comma)\n';) \
     printf '  "svg": "$(librsvg_VERSION)",\n'; \
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

    # Always build as shared library, we need
    # libvips-42.dll for the language bindings.
    $(MXE_MESON_WRAPPER) \
        --default-library=shared \
        -Ddeprecated=false \
        -Dintrospection=false \
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
