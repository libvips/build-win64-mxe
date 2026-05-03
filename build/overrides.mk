$(info [overrides]   $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 2.44.2
# gdk-pixbuf is still used by OpenSlide
gdk-pixbuf_VERSION  := 2.44.6
gdk-pixbuf_CHECKSUM := 140c2d0b899fcf853ee92b26373c9dc228dbcde0820a4246693f4328a27466fa
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# upstream version is 1.5.23
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.30
matio_CHECKSUM := 8bd3b9477042ecc00dd71c04762fa58468e14cccc32fd8c6826c2da1e8bc3107
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 3.4.0
libarchive_VERSION  := 3.8.7
libarchive_CHECKSUM := d3a8ba457ae25c27c84fd2830a2efdcc5b1d40bf585d4eb0d35f47e99e5d4774
libarchive_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libarchive-[0-9]*.patch)))
libarchive_SUBDIR   := libarchive-$(libarchive_VERSION)
libarchive_FILE     := libarchive-$(libarchive_VERSION).tar.xz
libarchive_URL      := https://github.com/libarchive/libarchive/releases/download/v$(libarchive_VERSION)/$(libarchive_FILE)

# upstream version is 7.1.2-17
imagemagick_VERSION  := 7.1.2-21
imagemagick_CHECKSUM := 4ba5b81797910efa93e65fb5a02b496284b8069d64513c6d2687c80d180dd70f
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick/tags

# upstream version is 2.40.21
librsvg_VERSION  := 2.62.1
librsvg_CHECKSUM := b41ca84206242fddd826a2bf76348d7cdf52c1050cbfa060b866e81a252145c3
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.0.13
fribidi_VERSION  := 1.0.16
fribidi_CHECKSUM := 1b1cde5b235d40479e91be2f0e88a309e3214c8ab470ec8a2744d82a5a9ea05c
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_GH_CONF  := fribidi/fribidi/releases,v,,,,.tar.xz

# upstream version is 2.88.0
glib_VERSION  := 2.88.1
glib_CHECKSUM := 51ab804c56f6eab3e5045c774d1290ac5e4c923d4f9a3d8e33123bee45c1840e
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 2.7.5
expat_VERSION  := 2.8.0
expat_CHECKSUM := a37bfae0aa9775bd8521ebd85dc456d486f0ff31138f6c91fd902ea732624542
expat_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/expat-[0-9]*.patch)))
expat_SUBDIR   := expat-$(expat_VERSION)
expat_FILE     := expat-$(expat_VERSION).tar.xz
expat_URL      := https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(expat_VERSION))/$(expat_FILE)

# upstream version is 0.6.22
libexif_VERSION  := 0.6.26
libexif_CHECKSUM := 4a055ed6575e61ca46c3172be3c753cc16c9becd0f99ec71d58dd0e471476c0c
libexif_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libexif-[0-9]*.patch)))
libexif_GH_CONF  := libexif/libexif/releases,v,,,,.tar.xz

# upstream version is 4.6.3
cfitsio_VERSION  := 4.6.4
cfitsio_CHECKSUM := 227b637b91c9820ea96f39a65eb087f053de567d82f4338e2884f123f8183c55
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio-$(cfitsio_VERSION)
cfitsio_FILE     := cfitsio-$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)

# upstream version is 4.7.1
tiff_VERSION  := c09bb26
tiff_CHECKSUM := e99a792bf6d39b2311f769243e921a4d2aba374344100dbe72b5a66ccd4a7747
tiff_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/tiff-[0-9]*.patch)))
tiff_SUBDIR   := libtiff-$(tiff_VERSION)
tiff_FILE     := libtiff-$(tiff_VERSION).tar.gz
tiff_URL      := https://gitlab.com/libtiff/libtiff/-/archive/$(tiff_VERSION)/$(tiff_FILE)

# upstream version is 2.18
# cannot use GH_CONF:
# lcms_GH_CONF  := mm2/Little-CMS,lcms
lcms_VERSION  := 2.19
lcms_CHECKSUM := 49e7e134e4299733dd0eda434fa468997a28ab3d33fa397c642b03644f552216
lcms_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lcms-[0-9]*.patch)))
lcms_SUBDIR   := lcms2-$(lcms_VERSION)
lcms_FILE     := lcms2-$(lcms_VERSION).tar.gz
lcms_URL      := https://github.com/mm2/Little-CMS/releases/download/lcms$(lcms_VERSION)/$(lcms_FILE)

# upstream version is 13.2.1
harfbuzz_VERSION  := 14.2.0
harfbuzz_CHECKSUM := 94017020f96d025bb66ae91574e4cf334bcad23e8175a8a40565b3721bc2eaff
harfbuzz_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
harfbuzz_GH_CONF  := harfbuzz/harfbuzz/releases,,,,,.tar.xz

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := AcademySoftwareFoundation/openexr/releases,v
# 3.2.0 requires libdeflate instead of zlib
# 3.4.0 requires OpenJPH
openexr_VERSION  := 3.1.13
openexr_CHECKSUM := 466213c67b6f45ae2642de762b8c327e01c2f29e0aec56ff62215391e4e06440
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   :=
openexr_FILE     := openexr-v$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/AcademySoftwareFoundation/openexr/releases/download/v$(openexr_VERSION)/$(openexr_FILE)

# upstream version is 0.21.1
libraw_VERSION  := 0.22.1
libraw_CHECKSUM := a789dc4e2409e2901d93793a4e0b80c7b49d0d97cf6ad71c850eb7616acfd786
libraw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libraw-[0-9]*.patch)))
libraw_SUBDIR   := LibRaw-$(libraw_VERSION)
libraw_FILE     := LibRaw-$(libraw_VERSION).tar.gz
libraw_URL      := https://www.libraw.org/data/$(libraw_FILE)

# upstream version is 3.3.10
fftw_VERSION  := 3.3.11
fftw_CHECKSUM := 5630c24cdeb33b131612f7eb4b1a9934234754f9f388ff8617458d0be6f239a1
fftw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

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
adwaita-icon-theme_VERSION  := 50.0
adwaita-icon-theme_CHECKSUM := fac6e0401fca714780561a081b8f7e27c3bc1db34ebda4da175081f26b24d460
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
imath_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imath-[0-9]*.patch)))
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

# icu will pull in standard linux headers, which we don't want
# skip building newly-added harfbuzz-vector and harfbuzz-raster libraries
# skip building unused harfbuzz-subset and harfbuzz-gpu libraries
# build with Meson
define harfbuzz_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dicu=disabled \
        -Draster=disabled \
        -Dvector=disabled \
        -Dsubset=disabled \
        -Dgpu=disabled \
        -Dgpu_demo=disabled \
        -Dtests=disabled \
        -Dintrospection=disabled \
        -Ddocs=disabled \
        -Dbenchmark=disabled \
        $(PKG_MESON_OPTS) \
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
# suppress stray terminal window in utils with -Wl,-subsystem,windows, see:
# https://github.com/libvips/libvips/pull/4683#issuecomment-3339022812
define imagemagick_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-fftw \
        --without-fontconfig \
        --without-gdi32 \
        --without-gvc \
        --without-heic \
        --without-jxl \
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
        --without-zstd \
        --without-threads \
        --disable-largefile \
        --disable-opencl \
        --disable-openmp \
        --disable-deprecated \
        $(PKG_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_DOCS) UTILITIES_LDFLAGS_EXTRA="-municode -Wl,-subsystem,windows"
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
        -DCMAKE_BUILD_TYPE=MinSizeRel \
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

    $(MXE_MESON_WRAPPER) \
        --buildtype=plain \
        -Dintrospection=disabled \
        -Dpixbuf=disabled \
        -Dpixbuf-loader=disabled \
        -Drsvg-convert=disabled \
        -Ddocs=disabled \
        -Dvala=disabled \
        -Dtests=false \
        -Dtriplet='$(PROCESSOR)-pc-windows-gnullvm' \
        -Dc_link_args='$(LDFLAGS) -lntdll -luserenv' \
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
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DZLIB_BUILD_TESTING=OFF \
        -DZLIB_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DZLIB_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

define zlib_BUILD_SHARED
    $($(PKG)_BUILD)
endef

# build with CMake
# avoid building unnecessary things
# disable the C++ API for now, we don't use it anyway
# build without lzma and zstd
# disable old-style JPEG in TIFF images, see:
# https://github.com/libvips/libvips/issues/1328#issuecomment-572020749
define tiff_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -Dtiff-contrib=OFF \
        -Dtiff-cxx=OFF \
        -Dtiff-docs=OFF \
        -Dtiff-tests=OFF \
        -Dtiff-tools=OFF \
        -Dmdi=OFF \
        -Djbig=OFF \
        -Dlerc=OFF \
        -Dlibdeflate=OFF \
        -Dlzma=OFF \
        -Dold-jpeg=OFF \
        -Dpixarlog=OFF \
        -Dtiff-opengl=OFF \
        -Dzstd=OFF \
        $(PKG_CMAKE_OPTS) \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
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

# build statically
# disable tests
define imath_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DBUILD_SHARED_LIBS=OFF \
        -DBUILD_TESTING=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# build with CMake.
define openexr_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DOPENEXR_INSTALL_PKG_CONFIG=ON \
        -DOPENEXR_INSTALL_TOOLS=OFF \
        -DOPENEXR_BUILD_TOOLS=OFF \
        -DBUILD_TESTING=OFF \
        -DCMAKE_C_FLAGS='$(CFLAGS) -Wno-error=incompatible-pointer-types' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

define cfitsio_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
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

# Disable tests and tools
# Strip during install if needed
define brotli_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DBROTLI_DISABLE_TESTS=ON \
        -DBROTLI_BUILD_TOOLS=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# build with --disable-load-extension and --disable-rpath
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
        --disable-load-extension \
        --disable-readline \
        --disable-rpath
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# build with -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_TESTING=OFF
define zstd_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DBUILD_TESTING=OFF \
        -DZSTD_BUILD_STATIC=$(CMAKE_STATIC_BOOL) \
        -DZSTD_BUILD_SHARED=$(CMAKE_SHARED_BOOL) \
        -DZSTD_BUILD_PROGRAMS=OFF \
        '$(SOURCE_DIR)/build/cmake'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
