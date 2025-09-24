$(info [overrides]   $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 2.42.12
# gdk-pixbuf is still used by OpenSlide
gdk-pixbuf_VERSION  := 2.44.1
gdk-pixbuf_CHECKSUM := 4eec84cfc55979045b3e0fca72c3cc081d556952ad33b30c7d29c0474db48a28
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.14.5
libxml2_VERSION  := 2.15.0
libxml2_CHECKSUM := 5abc766497c5b1d6d99231f662e30c99402a90d03b06c67b62d6c1179dedd561
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.xz
libxml2_URL      := https://download.gnome.org/sources/libxml2/$(call SHORT_PKG_VERSION,libxml2)/$(libxml2_FILE)

# upstream version is 1.5.23
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.28
matio_CHECKSUM := 9da698934a21569af058e6348564666f45029e6c2b0878ca0d8f9609bf77b8d8
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 3.4.0
libarchive_VERSION  := 3.8.1
libarchive_CHECKSUM := 19f917d42d530f98815ac824d90c7eaf648e9d9a50e4f309c812457ffa5496b5
libarchive_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libarchive-[0-9]*.patch)))
libarchive_SUBDIR   := libarchive-$(libarchive_VERSION)
libarchive_FILE     := libarchive-$(libarchive_VERSION).tar.xz
libarchive_URL      := https://github.com/libarchive/libarchive/releases/download/v$(libarchive_VERSION)/$(libarchive_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.13-29
imagemagick_CHECKSUM := 822a472f2b42a9e116536291d73bc375532a8690892d4191855971d77198edac
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# alternatively, one could build libvips with GraphicsMagick
# upstream version is 1.3.38
graphicsmagick_VERSION  := 1.3.45
graphicsmagick_CHECKSUM := dcea5167414f7c805557de2d7a47a9b3147bcbf617b91f5f0f4afe5e6543026b
graphicsmagick_SUBDIR   := GraphicsMagick-$(graphicsmagick_VERSION)
graphicsmagick_FILE     := GraphicsMagick-$(graphicsmagick_VERSION).tar.xz
graphicsmagick_URL      := https://$(SOURCEFORGE_MIRROR)/project/graphicsmagick/graphicsmagick/$(graphicsmagick_VERSION)/$(graphicsmagick_FILE)

# upstream version is 2.40.21
librsvg_VERSION  := 2.61.1
librsvg_CHECKSUM := bc1bbcd419120b098db28bea55335d9de2470d4e6a9f6ee97207b410fc15867d
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.51.0
pango_VERSION  := 1.57.0
pango_CHECKSUM := 890640c841dae77d3ae3d8fe8953784b930fa241b17423e6120c7bfdf8b891e7
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.13
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.16
fribidi_CHECKSUM := 1b1cde5b235d40479e91be2f0e88a309e3214c8ab470ec8a2744d82a5a9ea05c
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 2.85.4
glib_VERSION  := 2.86.0
glib_CHECKSUM := b5739972d737cfb0d6fd1e7f163dfe650e2e03740bb3b8d408e4d1faea580d6d
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 2.7.1
expat_VERSION  := 2.7.2
expat_CHECKSUM := 21b778b34ec837c2ac285aef340f9fb5fa063a811b21ea4d2412a9702c88995c
expat_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/expat-[0-9]*.patch)))
expat_SUBDIR   := expat-$(expat_VERSION)
expat_FILE     := expat-$(expat_VERSION).tar.xz
expat_URL      := https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(expat_VERSION))/$(expat_FILE)

# upstream version is 0.6.22
libexif_VERSION  := 0.6.25
libexif_CHECKSUM := 62f74cf3bf673a6e24d2de68f6741643718541f83aca5947e76e3978c25dce83
libexif_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libexif-[0-9]*.patch)))
libexif_GH_CONF  := libexif/libexif/releases,v,,,,.tar.xz

# upstream version is 4.7.0
tiff_VERSION  := 4.7.1
tiff_CHECKSUM := b92017489bdc1db3a4c97191aa4b75366673cb746de0dce5d7a749d5954681ba
tiff_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/tiff-[0-9]*.patch)))
tiff_SUBDIR   := tiff-$(tiff_VERSION)
tiff_FILE     := tiff-$(tiff_VERSION).tar.xz
tiff_URL      := https://download.osgeo.org/libtiff/$(tiff_FILE)

# upstream version is 4.5.0
cfitsio_VERSION  := 4.6.2
cfitsio_CHECKSUM := 66fd078cc0bea896b0d44b120d46d6805421a5361d3a5ad84d9f397b1b5de2cb
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio-$(cfitsio_VERSION)
cfitsio_FILE     := cfitsio-$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)

# upstream version is 11.4.5
harfbuzz_VERSION  := 11.5.0
harfbuzz_CHECKSUM := 2d30ba45c4c8ec4de661a1002b4f88d0841ff1a3087f34629275f5436d722109
harfbuzz_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
harfbuzz_GH_CONF  := harfbuzz/harfbuzz/releases,,,,,.tar.xz

# upstream version is 2.16.0
fontconfig_VERSION  := 2.17.1
fontconfig_CHECKSUM := 9f5cae93f4fffc1fbc05ae99cdfc708cd60dfd6612ffc0512827025c026fa541
fontconfig_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fontconfig-[0-9]*.patch)))
fontconfig_SUBDIR   := fontconfig-$(fontconfig_VERSION)
fontconfig_FILE     := fontconfig-$(fontconfig_VERSION).tar.xz
fontconfig_URL      := https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/$(fontconfig_VERSION)/$(fontconfig_FILE)

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := AcademySoftwareFoundation/openexr/tags
# 3.2.0 requires libdeflate instead of zlib
openexr_VERSION  := 3.1.11
openexr_CHECKSUM := 06b4a20d0791b5ec0f804c855d320a0615ce8445124f293616a086e093f1f1e1
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/AcademySoftwareFoundation/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 2.13.3
freetype_VERSION  := 2.14.1
freetype_CHECKSUM := 32427e8c471ac095853212a37aef816c60b42052d4d9e48230bab3bdf2936ccc
freetype_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/freetype-[0-9]*.patch)))
freetype_SUBDIR   := freetype-$(freetype_VERSION)
freetype_FILE     := freetype-$(freetype_VERSION).tar.xz
freetype_URL      := https://$(SOURCEFORGE_MIRROR)/project/freetype/freetype2/$(freetype_VERSION)/$(freetype_FILE)

# upstream version is 2.13.3
freetype-bootstrap_VERSION  := $(freetype_VERSION)
freetype-bootstrap_CHECKSUM := $(freetype_CHECKSUM)
freetype-bootstrap_PATCHES  := $(freetype_PATCHES)
freetype-bootstrap_SUBDIR   := $(freetype_SUBDIR)
freetype-bootstrap_FILE     := $(freetype_FILE)
freetype-bootstrap_URL      := $(freetype_URL)

# upstream version is 3.0.1
libjpeg-turbo_VERSION  := 3.1.0
libjpeg-turbo_CHECKSUM := 9564c72b1dfd1d6fe6274c5f95a8d989b59854575d4bbee44ade7bc17aa9bc93
libjpeg-turbo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))
libjpeg-turbo_SUBDIR   := libjpeg-turbo-$(libjpeg-turbo_VERSION)
libjpeg-turbo_FILE     := libjpeg-turbo-$(libjpeg-turbo_VERSION).tar.gz
libjpeg-turbo_URL      := https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/$(libjpeg-turbo_VERSION)/$(libjpeg-turbo_FILE)

# upstream version is 2.5.3
openjpeg_VERSION  := 2.5.4
openjpeg_CHECKSUM := a695fbe19c0165f295a8531b1e4e855cd94d0875d2f88ec4b61080677e27188a
openjpeg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openjpeg-[0-9]*.patch)))
openjpeg_GH_CONF  := uclouvain/openjpeg/tags,v

# upstream version is 25.08.0
poppler_VERSION  := 25.09.1
poppler_CHECKSUM := 0c1091d01d3dd1664a13816861e812d02b29201e96665454b81b52d261fad658
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))
poppler_SUBDIR   := poppler-$(poppler_VERSION)
poppler_FILE     := poppler-$(poppler_VERSION).tar.xz
poppler_URL      := https://poppler.freedesktop.org/$(poppler_FILE)

# upstream version is 0.21.1
libraw_VERSION  := 0.21.4
libraw_CHECKSUM := 6be43f19397e43214ff56aab056bf3ff4925ca14012ce5a1538a172406a09e63
libraw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libraw-[0-9]*.patch)))
libraw_SUBDIR   := LibRaw-$(libraw_VERSION)
libraw_FILE     := LibRaw-$(libraw_VERSION).tar.gz
libraw_URL      := https://www.libraw.org/data/$(libraw_FILE)

# upstream version is 2.7.1
# needed by nip4
gsl_VERSION  := 2.8
gsl_CHECKSUM := 6a99eeed15632c6354895b1dd542ed5a855c0f15d9ad1326c6fe2b2c9e423190
gsl_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gsl-[0-9]*.patch)))
gsl_SUBDIR   := gsl-$(gsl_VERSION)
gsl_FILE     := gsl-$(gsl_VERSION).tar.gz
gsl_URL      := https://ftp.gnu.org/gnu/gsl/$(gsl_FILE)
gsl_URL_2    := https://ftp.snt.utwente.nl/pub/software/gnu/gsl/$(gsl_FILE)

# upstream version is 3.36.1
# needed by nip4 and vipsdisp
adwaita-icon-theme_VERSION  := 48.1
adwaita-icon-theme_CHECKSUM := cbfe9b86ebcd14b03ba838c49829f7e86a7b132873803b90ac10be7d318a6e12
adwaita-icon-theme_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/adwaita-icon-theme-[0-9]*.patch)))
adwaita-icon-theme_SUBDIR   := adwaita-icon-theme-$(adwaita-icon-theme_VERSION)
adwaita-icon-theme_FILE     := adwaita-icon-theme-$(adwaita-icon-theme_VERSION).tar.xz
adwaita-icon-theme_URL      := https://download.gnome.org/sources/adwaita-icon-theme/$(firstword $(subst ., ,$(adwaita-icon-theme_VERSION)))/$(adwaita-icon-theme_FILE)

## Patches that we override with our own

cairo_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cfitsio_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
fftw_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fontconfig_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fontconfig-[0-9]*.patch)))
freetype_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/freetype-[0-9]*.patch)))
freetype-bootstrap_PATCHES := $(freetype_PATCHES)
gdk-pixbuf_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
glib_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
harfbuzz_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
lcms_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lcms-[0-9]*.patch)))
libjpeg-turbo_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))
libraw_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libraw-[0-9]*.patch)))
libxml2_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
meson_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/meson-[0-9]*.patch)))
mingw-w64_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
pixman_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pixman-[0-9]*.patch)))
poppler_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))
sqlite_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/sqlite-[0-9]*.patch)))
tiff_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/tiff-[0-9]*.patch)))

# zlib will make libzlib.dll, but we want libz.dll so we must
# patch CMakeLists.txt
zlib_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

## Override sub-dependencies
# adwaita-icon-theme:
#  Added: meson-wrapper
#  Removed: gettext
# freetype:
#  Added: meson-wrapper
#  Removed: brotli, bzip2
# freetype-bootstrap:
#  Added: meson-wrapper
#  Removed: bzip2
# GLib:
#  Removed: dbus, libiconv, pcre2
# GDK-PixBuf:
#  Removed: jasper, libiconv
#  Replaced: jpeg with libjpeg-turbo
# lcms:
#  Added: meson-wrapper
#  Removed: jpeg, tiff
# libtiff:
#  Replaced: jpeg with libjpeg-turbo
#  Removed: xz, zstd
# ImageMagick / GraphicsMagick:
#  Added: libxml2, openjpeg
#  Removed: bzip2, ffmpeg, fftw, freetype, jasper, liblqr-1, libltdl, libpng, libraw, openexr, pthreads, tiff, zlib
#  Replaced: jpeg with libjpeg-turbo
# OpenEXR:
#  Removed: pthreads
# Poppler:
#  Added: libjpeg-turbo, lcms
#  Removed: boost, curl, qt6-qtbase, libwebp
# librsvg:
#  Added: meson-wrapper, libxml2, rust, $(BUILD)~cargo-c
#  Removed: gdk-pixbuf, libcroco, libgsf
# Cairo:
#  Removed: lzo
# matio:
#  Removed: hdf5
# libjpeg-turbo:
#  Replaced: yasm with $(BUILD)~nasm
# libraw:
#  Added: zlib
#  Replaced: jpeg with libjpeg-turbo
#  Removed: jasper
# libxml2:
#  Added: meson-wrapper
#  Removed: libiconv, xz, zlib
# Fontconfig:
#  Added: meson-wrapper
#  Removed: gettext
# libexif:
#  Removed: gettext
# HarfBuzz:
#  Removed: brotli, icu4c
# libarchive:
#  Removed: bzip2, libiconv, libxml2, nettle, openssl, xz
# SQLite:
#  Added: zlib
#  Removed: dlfcn-win32

adwaita-icon-theme_DEPS := $(subst gettext,meson-wrapper,$(adwaita-icon-theme_DEPS))
freetype_DEPS           := $(subst brotli bzip2,meson-wrapper,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst brotli bzip2,meson-wrapper,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc meson-wrapper gettext libffi zlib
gdk-pixbuf_DEPS         := cc meson-wrapper glib libjpeg-turbo libpng tiff
lcms_DEPS               := $(subst jpeg tiff,meson-wrapper,$(lcms_DEPS))
tiff_DEPS               := cc libjpeg-turbo libwebp zlib
imagemagick_DEPS        := cc libxml2 openjpeg lcms libjpeg-turbo
graphicsmagick_DEPS     := $(imagemagick_DEPS)
openexr_DEPS            := cc imath zlib
poppler_DEPS            := cc cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
librsvg_DEPS            := cc meson-wrapper cairo glib pango libxml2 rust $(BUILD)~cargo-c
cairo_DEPS              := $(filter-out lzo ,$(cairo_DEPS))
matio_DEPS              := $(filter-out hdf5 ,$(matio_DEPS))
libjpeg-turbo_DEPS      := $(subst yasm,$(BUILD)~nasm,$(libjpeg-turbo_DEPS))
libraw_DEPS             := cc libjpeg-turbo lcms zlib
libxml2_DEPS            := cc meson-wrapper
fontconfig_DEPS         := cc meson-wrapper expat freetype-bootstrap
libexif_DEPS            := $(filter-out  gettext,$(libexif_DEPS))
harfbuzz_DEPS           := cc meson-wrapper cairo freetype-bootstrap glib
libarchive_DEPS         := cc zlib
sqlite_DEPS             := cc zlib

## Override build scripts

# build with the Meson build system
define adwaita-icon-theme_BUILD
    $(MXE_MESON_WRAPPER) '$(SOURCE_DIR)' '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# libasprintf isn't needed, so build with --disable-libasprintf
# this definition is for reference purposes only, we use the
# proxy-libintl plugin instead.
define gettext_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/gettext-runtime/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --disable-java \
        --disable-native-java \
        --disable-csharp \
        --enable-threads=win32 \
        --without-libexpat-prefix \
        --without-libxml2-prefix \
        --disable-libasprintf \
        --disable-nls \
        CONFIG_SHELL=$(SHELL)
    $(MAKE) -C '$(BUILD_DIR)/intl' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)/intl' -j 1 $(INSTALL_STRIP_LIB)
endef

# disable version script on llvm-mingw
# disable struct support and make the raw api unavailable when
# building a statically linked binary
define libffi_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-multi-os-directory \
        $(if $(BUILD_STATIC), \
            --disable-structs \
            --disable-raw-api) \
        --disable-symvers

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)

    '$(TARGET)-gcc' \
        -W -Wall -Werror -std=c99 -pedantic \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libffi.exe' \
        `'$(TARGET)-pkg-config' libffi --cflags --libs`
endef

# disable programs
# build with --disable-nls
define libexif_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# icu will pull in standard linux headers, which we don't want,
# build with Meson.
define harfbuzz_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dicu=disabled \
        -Dtests=disabled \
        -Dintrospection=disabled \
        -Ddocs=disabled \
        -Dbenchmark=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build with the Meson build system
# build without bzip2 and brotli
define freetype_BUILD_COMMON
    $(MXE_MESON_WRAPPER) \
        -Dharfbuzz=enabled \
        -Dpng=enabled \
        -Dzlib=enabled \
        -Dbrotli=disabled \
        -Dbzip2=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

define freetype_BUILD
    $($(PKG)_BUILD_COMMON)
endef

define freetype-bootstrap_BUILD
    $(subst harfbuzz=enabled,harfbuzz=disabled,$(freetype_BUILD_COMMON))
endef

# build with the Meson build system
define gdk-pixbuf_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dtiff=disabled \
        -Dgif=disabled \
        -Dothers=disabled \
        -Dglycin=disabled \
        -Dthumbnailer=disabled \
        -Dintrospection=disabled \
        -Dtests=false \
        -Dinstalled_tests=false \
        -Ddocumentation=false \
        -Dman=false \
        -Dbuiltin_loaders='png,jpeg' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build pixman with the Meson build system
define pixman_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dopenmp=disabled \
        -Dgtk=disabled \
        -Dtests=disabled \
        -Ddemos=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build fribidi with the Meson build system
define fribidi_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dtests=false \
        -Ddocs=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build with the Meson build system
# exclude jpeg, tiff dependencies
# build with -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT to avoid a
# horrible hack (we don't target pre-Windows XP, so it should be safe)
define lcms_BUILD
    $(eval export CFLAGS += -O3)

    $(MXE_MESON_WRAPPER) \
        -Dtests=disabled \
        -Djpeg=disabled \
        -Dtiff=disabled \
        -Dc_args='$(CFLAGS) -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# disable largefile support, we rely on vips for that and ImageMagick's
# detection does not work when cross-compiling
# build with jpeg-turbo and without lzma
# disable POSIX threads with --without-threads, use Win32 threads instead
# avoid linking against -lgdi32, see: https://github.com/kleisauke/net-vips/issues/61
# exclude deprecated methods in MagickCore API
define imagemagick_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-fftw \
        --without-fontconfig \
        --without-gdi32 \
        --without-gvc \
        --without-heic \
        --without-heif \
        --without-jxl \
        --without-ltdl \
        --without-lqr \
        --without-lzma \
        --without-magick-plus-plus \
        --without-modules \
        --without-openexr \
        --without-pango \
        --without-png \
        --without-rsvg \
        --without-tiff \
        --without-webp \
        --without-x \
        --without-zlib \
        --without-threads \
        --disable-largefile \
        --disable-opencl \
        --disable-openmp \
        --disable-deprecated \
        $(PKG_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_DOCS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_DOCS)
endef

# Alias GraphicsMagick build with ImageMagick
define graphicsmagick_BUILD
    $(imagemagick_BUILD)
endef

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the
# libjpeg API)
# Switch to NASM because YASM has been unmaintained for a few years, while NASM is actively maintained.
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DWITH_TURBOJPEG=OFF \
        -DPNG_SUPPORTED=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER='$(PREFIX)/$(BUILD)/bin/nasm' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# build without jasper, openmp and examples
define libraw_BUILD
    # autoreconf to get updated libtool files for clang
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-examples \
        --disable-openmp \
        --disable-jasper \
        --enable-jpeg \
        --enable-zlib \
        --enable-lcms

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)
endef

# build with the Meson build system
# build with -Dnls=disabled
define fontconfig_BUILD
    $(MXE_MESON_WRAPPER) \
        -Ddoc=disabled \
        -Dnls=disabled \
        -Dtests=disabled \
        -Dtools=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# disable GObject introspection
# build with the Meson build system
# force FontConfig since the Win32 font backend within Cairo is disabled
define pango_BUILD
    # Disable utils and tools
    $(SED) -i "/subdir('utils')/{N;d;}" '$(SOURCE_DIR)/meson.build'

    $(MXE_MESON_WRAPPER) \
        -Ddocumentation=false \
        -Dbuild-testsuite=false \
        -Dbuild-examples=false \
        -Dintrospection=disabled \
        -Dfontconfig=enabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# compile with the Rust toolchain
define librsvg_BUILD
    $(eval export CARGO_HOME := $(PREFIX)/$(TARGET)/.cargo)

    # Enable networking while we build librsvg
    $(eval export MXE_ENABLE_NETWORK := 1)

    # Disable tools
    $(SED) -i "/subdir('rsvg_convert')/d" '$(SOURCE_DIR)/meson.build'

    # Ensure MXE's pkg-config wrapper finds librsvg-2.0-uninstalled.pc
    $(SED) -i "s/PKG_CONFIG_PATH/&_$(subst .,_,$(subst -,_,$(TARGET)))/" '$(SOURCE_DIR)/meson/cargo_wrapper.py'

    $(MXE_MESON_WRAPPER) \
        --buildtype=plain \
        -Dintrospection=disabled \
        -Dpixbuf=disabled \
        -Dpixbuf-loader=disabled \
        -Ddocs=disabled \
        -Dvala=disabled \
        -Dtests=false \
        -Dtriplet='$(PROCESSOR)-pc-windows-gnullvm' \
        -Dc_link_args='$(LDFLAGS) -lntdll -luserenv' \
        $(PKG_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install

    # Add native libraries needed for static linking to .pc file.
    # We cannot use rustc --print native-static-libs due to -Zbuild-std.
    # See: https://gitlab.gnome.org/GNOME/librsvg/-/issues/968
    $(SED) -i "/^Libs.private:/s/$$/ -lntdll -luserenv/" '$(PREFIX)/$(TARGET)/lib/pkgconfig/librsvg-2.0.pc'
endef

# compile with CMake
define poppler_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DENABLE_LIBTIFF=ON \
        -DENABLE_LIBPNG=ON \
        -DENABLE_GLIB=ON \
        -DENABLE_LCMS=ON \
        -DENABLE_LIBOPENJPEG='openjpeg2' \
        -DENABLE_DCTDECODER='libjpeg' \
        -DFONT_CONFIGURATION=win32 \
        -DENABLE_UNSTABLE_API_ABI_HEADERS=OFF \
        -DENABLE_NSS3=OFF \
        -DENABLE_GPGME=OFF \
        -DENABLE_BOOST=OFF \
        -DENABLE_CPP=OFF \
        -DBUILD_GTK_TESTS=OFF \
        -DENABLE_UTILS=OFF \
        -DENABLE_QT5=OFF \
        -DENABLE_QT6=OFF \
        -DENABLE_LIBCURL=OFF \
        -DBUILD_QT5_TESTS=OFF \
        -DBUILD_QT6_TESTS=OFF \
        -DBUILD_CPP_TESTS=OFF \
        -DBUILD_MANUAL_TESTS=OFF \
        -DENABLE_GTK_DOC=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# the zlib configure is a bit basic, so we'll use cmake
define zlib_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_BUILD_EXAMPLES=OFF \
        -DINSTALL_PKGCONFIG_DIR='$(PREFIX)/$(TARGET)/lib/pkgconfig' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

define zlib_BUILD_SHARED
    $($(PKG)_BUILD)
endef

# avoid building unnecessary things
# disable the C++ API for now, we don't use it anyway
# build without lzma and zstd
# disable old-style JPEG in TIFF images, see:
# https://github.com/libvips/libvips/issues/1328#issuecomment-572020749
define tiff_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-tools \
        --disable-tests \
        --disable-contrib \
        --disable-docs \
        --disable-mdi \
        --disable-pixarlog \
        --disable-old-jpeg \
        --disable-cxx \
        --disable-lzma \
        --disable-zstd \
        $(PKG_CONFIGURE_OPTS) \
        $(if $(and $(IS_JPEGLI),$(BUILD_STATIC)), LIBS="`'$(TARGET)-pkg-config' --libs libjpeg`")
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
endef

# disable unneeded loaders
define libwebp_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gl \
        --disable-sdl \
        --disable-png \
        --disable-jpeg \
        --disable-tiff \
        --disable-gif \
        --enable-libwebpmux \
        --enable-libwebpdemux
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# Disable the DWrite font backend to ensure compat with Windows Nano Server
# node-canvas needs a Cairo with SVG support, so compile with -Dpng=enabled
# ensure the FontConfig backend is enabled
# build with -Dzlib=disabled to disable the script, PostScript and PDF surfaces
define cairo_BUILD
    $(MXE_MESON_WRAPPER) \
        -Ddwrite=disabled \
        -Dfontconfig=enabled \
        -Dfreetype=enabled \
        -Dpng=enabled \
        -Dquartz=disabled \
        -Dtee=disabled \
        -Dxcb=disabled \
        -Dxlib=disabled \
        -Dxlib-xcb=disabled \
        -Dzlib=disabled \
        -Dtests=disabled \
        -Dgtk2-utils=disabled \
        -Dglib=enabled \
        -Dspectre=disabled \
        -Dsymbol-lookup=disabled \
        -Dgtk_doc=false \
        $(PKG_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

define matio_BUILD
    # https://github.com/tbeu/matio/issues/78 for ac_cv_va_copy
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        ac_cv_va_copy=C99
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
endef

define matio_BUILD_SHARED
    $($(PKG)_BUILD)
endef

# build with the Meson build system
# build a minimal libxml2, see: https://github.com/lovell/sharp-libvips/pull/92
define libxml2_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dminimum=true \
        $(PKG_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# Only build libarchive with zlib support
define libarchive_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-bz2lib \
        --without-libb2 \
        --without-iconv \
        --without-lz4 \
        --without-zstd \
        --without-lzma \
        --without-cng \
        --without-openssl \
        --without-xml2 \
        --without-expat \
        --disable-acl \
        --disable-xattr \
        --disable-bsdtar \
        --disable-bsdcat \
        --disable-bsdcpio \
        --disable-posix-regex-lib \
        $(if $(BUILD_STATIC), CFLAGS='$(CFLAGS) -DLIBARCHIVE_STATIC')
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
endef

# build with the Meson build system
# compile with the internal PCRE library
define glib_BUILD
    # Enable networking to allow gvdb to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 $(MXE_MESON_WRAPPER) \
        --force-fallback-for=gvdb \
        -Dsysprof=disabled \
        -Dtests=false \
        -Dnls=disabled \
        -Dglib_debug=disabled \
        -Dglib_assert=false \
        -Dglib_checks=false \
        $(PKG_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build with CMake.
define openexr_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DOPENEXR_INSTALL_PKG_CONFIG=ON \
        -DOPENEXR_INSTALL_TOOLS=OFF \
        -DOPENEXR_BUILD_TOOLS=OFF \
        -DBUILD_TESTING=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

define cfitsio_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DUSE_CURL=OFF \
        -DTESTS=OFF \
        -DUTILS=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-cfitsio.exe' \
        `'$(TARGET)-pkg-config' cfitsio --cflags --libs`
endef

# Disable tests
# Strip during install if needed
define brotli_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBROTLI_DISABLE_TESTS=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# build with --disable-load-extension
define sqlite_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        --host='$(TARGET)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        $(if $(BUILD_SHARED), \
            --out-implib \
            --enable-shared \
            --disable-static \
        $(else), \
            --enable-static \
            --disable-shared) \
        --disable-readline \
        --disable-load-extension
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
