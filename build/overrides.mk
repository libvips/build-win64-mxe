$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## GCC bootstrap options

# Override GCC patches with our own patches
gcc_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gcc-[0-9]*.patch)))

# We do not need OpenMP, so build with --disable-libgomp
# and compile without optimizations / stripping.
_gcc_CONFIGURE_OPTS=--with-build-sysroot='$(PREFIX)/$(TARGET)' \
--disable-libgomp \
CFLAGS='' \
CXXFLAGS='' \
LDFLAGS=''

## Update dependencies

# upstream version is 3.2.1
libffi_VERSION  := 3.3
libffi_CHECKSUM := 72fba7922703ddfa7a028d513ac15a85c8d54c8d67f55fa5a4802885dc652056
libffi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libffi-[0-9]*.patch)))
libffi_SUBDIR   := libffi-$(libffi_VERSION)
libffi_FILE     := libffi-$(libffi_VERSION).tar.gz
libffi_URL      := https://github.com/libffi/libffi/releases/download/v$(libffi_VERSION)/$(libffi_FILE)
libffi_URL_2    := https://sourceware.org/pub/libffi/$(libffi_FILE)

# upstream version is 2.32.3
gdk-pixbuf_VERSION  := 2.40.0
gdk-pixbuf_CHECKSUM := 1582595099537ca8ff3b99c6804350b4c058bb8ad67411bbaae024ee7cead4e6
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# upstream version is 1.5.2
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.18
matio_CHECKSUM := 5fad71a63a854d821cc6f4e8c84da837149dd5fb57e1e2baeffd85fa0f28fe25
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.11-30
imagemagick_CHECKSUM := 581e861341ec577daec8d0e2e5d69d8cb09b7fbda1e730169f4a0e20b348f6fe
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# upstream version is 2.40.5
librsvg_VERSION  := 2.50.0
librsvg_CHECKSUM := b3fadba240f09b9c9898ab20cb7311467243e607cf8f928b7c5f842474ee3df4
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.46.2
pango_CHECKSUM := d89fab5f26767261b493279b65cfb9eb0955cd44c07c5628d36094609fc51841
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.8
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.10
fribidi_CHECKSUM := 7f1c687c7831499bcacae5e8675945a39bacbad16ecaa945e9454a32df653c01
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 1.0.3
libwebp_VERSION  := 1.1.0
libwebp_CHECKSUM := 98a052268cc4d5ece27f76572a7f50293f439c17a98e67c4ea0c7ed6f50ef043
libwebp_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libwebp-[0-9]*.patch)))
libwebp_SUBDIR   := libwebp-$(libwebp_VERSION)
libwebp_FILE     := libwebp-$(libwebp_VERSION).tar.gz
libwebp_URL      := http://downloads.webmproject.org/releases/webp/$(libwebp_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.66.0
glib_CHECKSUM := c5a66bf143065648c135da4c943d2ac23cce15690fc91c358013b2889111156c
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
libgsf_VERSION  := 1.14.47
libgsf_CHECKSUM := d188ebd3787b5375a8fd38ee6f761a2007de5e98fa0cf5623f271daa67ba774d
libgsf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libgsf-[0-9]*.patch)))
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# upstream version is 1.16.0
cairo_VERSION  := 1.17.2
cairo_CHECKSUM := 6b70d4655e2a47a22b101c666f4b29ba746eda4aa8a0f7255b32b2e9408801df
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := http://cairographics.org/snapshots/$(cairo_FILE)

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := AcademySoftwareFoundation/openexr/tags
openexr_VERSION  := 2.5.3
openexr_CHECKSUM := 6a6525e6e3907715c6a55887716d7e42d09b54d2457323fcee35a0376960bebf
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/AcademySoftwareFoundation/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 2.2.0
# cannot use GH_CONF:
# ilmbase_GH_CONF  := openexr/openexr/tags
ilmbase_VERSION  := $(openexr_VERSION)
ilmbase_CHECKSUM := $(openexr_CHECKSUM)
ilmbase_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/ilmbase-[0-9]*.patch)))
ilmbase_SUBDIR   := $(openexr_SUBDIR)
ilmbase_FILE     := $(openexr_FILE)
ilmbase_URL      := $(openexr_URL)

# upstream version is 3410
cfitsio_VERSION  := 3.49
cfitsio_CHECKSUM := 5b65a20d5c53494ec8f638267fca4a629836b7ac8dd0ef0266834eab270ed4b3
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio-$(cfitsio_VERSION)
cfitsio_FILE     := cfitsio-$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)
cfitsio_URL_2    := https://mirrorservice.org/sites/distfiles.macports.org/cfitsio/$(cfitsio_FILE)

# upstream version is 0.33.6
pixman_VERSION  := 0.40.0
pixman_CHECKSUM := 6d200dec3740d9ec4ec8d1180e25779c00bc749f94278c8b9021f5534db223fc
pixman_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pixman-[0-9]*.patch)))
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# upstream version is 2.13.1
fontconfig_VERSION  := 2.13.92
fontconfig_CHECKSUM := 506e61283878c1726550bc94f2af26168f1e9f2106eac77eaaf0b2cdfad66e4e
fontconfig_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fontconfig-[0-9]*.patch)))
fontconfig_SUBDIR   := fontconfig-$(fontconfig_VERSION)
fontconfig_FILE     := fontconfig-$(fontconfig_VERSION).tar.xz
fontconfig_URL      := https://www.freedesktop.org/software/fontconfig/release/$(fontconfig_FILE)

# upstream version is 1.8.12
hdf5_VERSION  := 1.12.0
hdf5_CHECKSUM := 97906268640a6e9ce0cde703d5a71c9ac3092eded729591279bf2e3ca9765f61
hdf5_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/hdf5-[0-9]*.patch)))
hdf5_SUBDIR   := hdf5-$(hdf5_VERSION)
hdf5_FILE     := hdf5-$(hdf5_VERSION).tar.bz2
hdf5_URL      := https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$(call SHORT_PKG_VERSION,hdf5)/hdf5-$(hdf5_VERSION)/src/$(hdf5_FILE)

# upstream version is 2.14.02
nasm_VERSION  := 2.15.05
nasm_CHECKSUM := 3caf6729c1073bf96629b57cee31eeb54f4f8129b01902c73428836550b30a3f
nasm_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/nasm-[0-9]*.patch)))
nasm_SUBDIR   := nasm-$(nasm_VERSION)
nasm_FILE     := nasm-$(nasm_VERSION).tar.xz
nasm_URL      := https://www.nasm.us/pub/nasm/releasebuilds/$(nasm_VERSION)/$(nasm_FILE)

## Patches that we override with our own

libjpeg-turbo_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))
poppler_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))
libxml2_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
fftw_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))

# zlib will make libzlib.dll, but we want libz.dll so we must
# patch CMakeLists.txt
zlib_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

## Override sub-dependencies
# HarfBuzz:
#  Removed: icu4c
# libgsf:
#  Removed: bzip2
# freetype:
#  Removed: bzip2
# freetype-bootstrap:
#  Removed: bzip2
# GLib:
#  Removed: dbus, libiconv, pcre
# GDK-PixBuf:
#  Removed: jasper, libiconv
#  Replaced: jpeg with libjpeg-turbo
# lcms:
#  Removed: jpeg, tiff
# libtiff:
#  Replaced: jpeg with libjpeg-turbo
#  Removed: xz
# ImageMagick:
#  Added: libxml2, openjpeg
#  Removed: bzip2, ffmpeg, fftw, freetype, jasper, liblqr-1, libltdl, libpng, libraw, openexr, pthreads, tiff, zlib
#  Replaced: jpeg with libjpeg-turbo
# OpenEXR:
#  Removed: pthreads
# Pango:
#  Added: fribidi
# Poppler:
#  Added: mingw-std-threads, libjpeg-turbo, lcms
#  Removed: curl, qtbase, libwebp
# librsvg:
#  Added: libxml2, rust
#  Removed: libcroco, libgsf
# Cairo:
#  Removed: lzo
# hdf5:
#  Added: $(BUILD)~cmake
#  Removed: pthreads
# libjpeg-turbo:
#  Replaced: yasm with $(BUILD)~nasm
# libxml2:
#  Removed: xz
# Fontconfig:
#  Removed: gettext
# GCC:
#  Removed: $(BUILD)~zstd
# CFITSIO:
#  Added: zlib

harfbuzz_DEPS           := $(filter-out icu4c,$(harfbuzz_DEPS))
libgsf_DEPS             := $(filter-out bzip2 ,$(libgsf_DEPS))
freetype_DEPS           := $(filter-out bzip2 ,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(filter-out bzip2 ,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc gettext libffi zlib
gdk-pixbuf_DEPS         := cc glib libjpeg-turbo libpng tiff
lcms_DEPS               := $(filter-out jpeg tiff ,$(lcms_DEPS))
tiff_DEPS               := cc libjpeg-turbo libwebp zlib
imagemagick_DEPS        := cc libxml2 openjpeg lcms libjpeg-turbo
openexr_DEPS            := cc ilmbase zlib
pango_DEPS              := $(pango_DEPS) fribidi
poppler_DEPS            := cc mingw-std-threads cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
librsvg_DEPS            := $(filter-out libcroco libgsf ,$(librsvg_DEPS)) libxml2 rust
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman zlib
hdf5_DEPS               := $(filter-out pthreads ,$(hdf5_DEPS)) $(BUILD)~cmake
libjpeg-turbo_DEPS      := $(subst yasm,$(BUILD)~nasm,$(libjpeg-turbo_DEPS))
libxml2_DEPS            := $(filter-out xz ,$(libxml2_DEPS))
fontconfig_DEPS         := $(filter-out  gettext,$(fontconfig_DEPS))
gcc_DEPS                := $(filter-out $(BUILD)~zstd,$(gcc_DEPS))
cfitsio_DEPS            := cc zlib

## Override build scripts

# The minimum Windows version we support is Windows 7, so build with:
#   --with-default-msvcrt=msvcrt \
#   --with-default-win32-winnt=0x601 \
# Install the headers in $(PREFIX)/$(TARGET)/mingw since
# we need to distribute the /include and /lib directories
# Note: Building with --with-default-msvcrt=ucrt breaks
# compatibility with the prebuilt Rust binaries that
# is built in msvcrt mode.
define gcc_BUILD_mingw-w64
    # install mingw-w64 headers
    $(call PREPARE_PKG_SOURCE,mingw-w64,$(BUILD_DIR))
    mkdir '$(BUILD_DIR).headers'
    cd '$(BUILD_DIR).headers' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-headers/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/mingw' \
        --enable-idl \
        --with-default-msvcrt=msvcrt \
        --with-default-win32-winnt=0x601 \
        $(mingw-w64-headers_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).headers' install

    # build standalone gcc
    $(gcc_CONFIGURE)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-gcc
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)-gcc

    # build mingw-w64-crt
    mkdir '$(BUILD_DIR).crt'
    cd '$(BUILD_DIR).crt' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-crt/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/mingw' \
        --with-default-msvcrt=msvcrt \
        @gcc-crt-config-opts@
    $(MAKE) -C '$(BUILD_DIR).crt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).crt' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build posix threads
    mkdir '$(BUILD_DIR).pthreads'
    cd '$(BUILD_DIR).pthreads' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-libraries/winpthreads/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --prefix='$(PREFIX)/$(TARGET)/mingw'
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build rest of gcc
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-target-libstdc++-v3
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    $(gcc_POST_BUILD)
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
    $(MAKE) -C '$(BUILD_DIR)/intl' -j 1 install
endef

# disable version script on llvm-mingw
# make the raw api unavailable when building a statically linked binary
define libffi_BUILD
    # build and install the library
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-multi-os-directory \
        $(if $(BUILD_STATIC), --disable-raw-api) \
        $(if $(IS_LLVM), --disable-symvers)

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        -W -Wall -Werror -std=c99 -pedantic \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-libffi.exe' \
        `'$(TARGET)-pkg-config' libffi --cflags --libs`
endef

# icu will pull in standard linux headers, which we don't want,
# build with Meson.
define harfbuzz_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dicu=disabled \
        -Dtests=disabled \
        -Dintrospection=disabled \
        -Ddocs=disabled \
        -Dbenchmark=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

define freetype_BUILD
    # alias libharfbuzz and libfreetype to satisfy circular dependence
    # libfreetype should already have been created by freetype-bootstrap.mk
    $(if $(BUILD_STATIC), \
        ln -sf libharfbuzz.a '$(PREFIX)/$(TARGET)/lib/libharfbuzz_too.a' \
        && ln -sf libfreetype.a '$(PREFIX)/$(TARGET)/lib/libfreetype_too.a',)
    $($(PKG)_BUILD_COMMON)
    $(if $(BUILD_STATIC), \
        # remove circular dependencies from pc file
        $(SED) -i '/^Libs.private:/s/\-lharfbuzz_too -lfreetype_too//g' '$(PREFIX)/$(TARGET)/lib/pkgconfig/freetype2.pc' \
        # avoid self-dependence within pc file
        $(SED) -i '/^Libs.private:/s/\-lfreetype//g' '$(PREFIX)/$(TARGET)/lib/pkgconfig/freetype2.pc')
endef

# exclude bz2 and gdk-pixbuf
define libgsf_BUILD
    $(SED) -i 's,\ssed\s, $(SED) ,g'           '$(SOURCE_DIR)'/gsf/Makefile.in

    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-gdk-pixbuf \
        --without-python \
        --without-bz2 \
        --with-zlib \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config'
    $(MAKE) -C '$(BUILD_DIR)'     -j '$(JOBS)' install-pkgconfigDATA $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)/gsf' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# build gdk-pixbuf with libjpeg-turbo
# and the Meson build system
define gdk-pixbuf_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dbuiltin_loaders='jpeg,png,tiff' \
        -Dgir=false \
        -Dx11=false \
        $(if $(IS_INTL_DUMMY), -Dc_link_args='-lintl') \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# build pixman with the Meson build system
define pixman_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dgtk=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# build fribidi with the Meson build system
define fribidi_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Ddocs=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# exclude jpeg, tiff dependencies
# build with -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT to avoid a
# horrible hack (we don't target pre-Windows XP, so it should be safe)
define lcms_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib \
        CFLAGS="$(CFLAGS) -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# disable largefile support, we rely on vips for that and ImageMagick's
# detection does not work when cross-compiling
# build with jpeg-turbo and without lzma
# disable POSIX threads with --without-threads, use Win32 threads instead
# exclude deprecated methods in MagickCore API
define imagemagick_BUILD
    # avoid linking against -lgdi32, see: https://github.com/kleisauke/net-vips/issues/61
    $(SED) -i 's,-lgdi32,,g' $(SOURCE_DIR)/configure

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-fftw \
        --without-fontconfig \
        --without-gvc \
        --without-heic \
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
        CFLAGS="$(CFLAGS) -DMAGICKCORE_EXCLUDE_DEPRECATED"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the
# libjpeg API)
# Switch to NASM because YASM has been unmaintained for a few years, while NASM is actively maintained.
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DWITH_TURBOJPEG=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER='$(PREFIX)/$(BUILD)/bin/nasm' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# build with --disable-nls
define fontconfig_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-arch='$(TARGET)' \
        --with-expat='$(PREFIX)/$(TARGET)' \
        --disable-docs \
        --disable-nls
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# disable GObject introspection
# build with the Meson build system
# force FontConfig since the Win32 font backend within Cairo is disabled
define pango_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dintrospection=false \
        -Duse_fontconfig=true \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# compile with the Rust toolchain
define librsvg_BUILD
    # Update expected Cargo SHA256 hashes for the
    # files we have patched in $(librsvg_PATCHES)
    # Note: These replacements can be removed when
    #       the patches have been accepted upstream.
    $(SED) -i 's/45d980167c6b1a2fd54f045f39e6322a7739be6c4723b8c373716f8252d3778c/f769fd23b7389e684b2f365a9f1038273788eb0f3d5907fe34f7ac5383b0daf0/' '$(SOURCE_DIR)/vendor/cairo-rs/.cargo-checksum.json'
    $(SED) -i 's/d8c54bf5eeba9d035434da591646047329e0cad2c0be93c10409f7b36a0e55ec/b03f53a3c001dcd51fac158e8ca17f0c15299c77edba59444e91b73bc2b2226a/' '$(SOURCE_DIR)/vendor/cairo-sys-rs/.cargo-checksum.json'

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-introspection \
        --disable-tools \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix \
        RUST_TARGET='$(PROCESSOR)-pc-windows-gnu' \
        CARGO='$(TARGET)-cargo' \
        RUSTC='$(TARGET)-rustc'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# compile with CMake and with libjpeg-turbo
define poppler_BUILD
    $(if $(WIN32_THREADS),\
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(poppler_PATCHES))))/poppler-mingw-std-threads.patch)

    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DENABLE_TESTS=OFF \
        -DENABLE_ZLIB=ON \
        -DENABLE_LIBTIFF=ON \
        -DENABLE_LIBPNG=ON \
        -DENABLE_GLIB=ON \
        -DENABLE_CMS='lcms2' \
        -DENABLE_LIBOPENJPEG='openjpeg2' \
        -DENABLE_DCTDECODER='libjpeg' \
        -DFONT_CONFIGURATION=win32 \
        -DENABLE_UNSTABLE_API_ABI_HEADERS=OFF \
        -DENABLE_SPLASH=OFF \
        -DENABLE_CPP=OFF \
        -DBUILD_GTK_TESTS=OFF \
        -DENABLE_UTILS=OFF \
        -DENABLE_QT5=OFF \
        -DENABLE_LIBCURL=OFF \
        -DBUILD_QT5_TESTS=OFF \
        -DBUILD_CPP_TESTS=OFF \
        -DENABLE_GTK_DOC=OFF \
        $(if $(WIN32_THREADS), -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -I$(PREFIX)/$(TARGET)/include/mingw-std-threads') \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# the zlib configure is a bit basic, so we'll use cmake
define zlib_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DSKIP_BUILD_EXAMPLES=ON \
        -DINSTALL_PKGCONFIG_DIR='$(PREFIX)/$(TARGET)/lib/pkgconfig' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# disable the C++ API for now, we don't use it anyway
# build with libjpeg-turbo and without lzma
define tiff_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-x \
        --disable-cxx \
        --disable-lzma
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
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
        --disable-nls \
        --enable-libwebpmux \
        --enable-libwebpdemux
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# replace libpng12 with libpng16
# node-canvas needs a Cairo with SVG support, so compile only with --disable-svg when building a statically linked binary
# disable the PDF backend, we use Poppler for that
# disable the Win32 surface and font backend to avoid having to link against -lgdi32 and -lmsimg32, see: https://github.com/kleisauke/net-vips/issues/61
# disable the PostScript backend
# ensure the FontConfig backend is enabled
define cairo_BUILD
    $(SED) -i 's,libpng12,libpng16,g'                        '$(SOURCE_DIR)/configure.ac'
    $(SED) -i 's,^\(Libs:.*\),\1 @CAIRO_NONPKGCONFIG_LIBS@,' '$(SOURCE_DIR)/src/cairo.pc.in'

    # configure script is ancient so regenerate
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gl \
        --disable-test-surfaces \
        --disable-gcov \
        --disable-xlib \
        --disable-xlib-xrender \
        --disable-xcb \
        --disable-quartz \
        --disable-quartz-font \
        --disable-quartz-image \
        --disable-os2 \
        --disable-beos \
        --disable-directfb \
        --disable-atomic \
        --disable-ps \
        --disable-script \
        --disable-pdf \
        $(if $(BUILD_STATIC), --disable-svg) \
        --disable-win32 \
        --disable-win32-font \
        --disable-interpreter \
        --enable-png \
        --enable-fc \
        --enable-ft \
        --without-x \
        CFLAGS="$(CFLAGS) $(if $(BUILD_STATIC),-DCAIRO_WIN32_STATIC_BUILD)" \
        $(if $(findstring win32,$(TARGET)), ax_cv_c_float_words_bigendian=no)

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

define matio_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        ac_cv_va_copy=C99
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

define matio_BUILD_SHARED
    $($(PKG)_BUILD)
endef

# build without lzma, disable the linker version script on llvm-mingw
define libxml2_BUILD
    $(SED) -i 's,`uname`,MinGW,g' '$(1)/xml2-config.in'

    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib='$(PREFIX)/$(TARGET)/lib' \
        --without-lzma \
        --without-debug \
        --without-iconv \
        --without-python \
        --without-threads \
        $(if $(IS_LLVM), --disable-ld-version-script)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
    ln -sf '$(PREFIX)/$(TARGET)/bin/xml2-config' '$(PREFIX)/bin/$(TARGET)-xml2-config'
endef

# build with the Meson build system
# compile with the internal PCRE library
define glib_BUILD
    # other packages expect glib-tools in $(TARGET)/bin
    rm -f  '$(PREFIX)/$(TARGET)/bin/glib-*'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-genmarshal'        '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-schemas'   '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-resources' '$(PREFIX)/$(TARGET)/bin/'

    $(if $(BUILD_STATIC), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(glib_PATCHES))))/glib-static.patch)

    # cross build
    # build as shared library, since we need `libgobject-2.0-0.dll`
    # and `libglib-2.0-0.dll` for the language bindings.
    '$(TARGET)-meson' \
        --default-library=shared \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dforce_posix_threads=false \
        -Dinternal_pcre=true \
        -Dnls=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install

    # remove static dummy dependency from pc file
    $(if $(IS_INTL_DUMMY), \
        $(SED) -i '/^Libs:/s/\-lintl//g' '$(PREFIX)/$(TARGET)/lib/pkgconfig/glib-2.0.pc')
endef

# build with CMake.
define openexr_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DOPENEXR_CXX_STANDARD=14 \
        -DOPENEXR_INSTALL_PKG_CONFIG=ON \
        -DBUILD_TESTING=OFF \
        -DOPENEXR_BUILD_UTILS=OFF \
        '$(SOURCE_DIR)/OpenEXR'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# build with CMake.
define ilmbase_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        $(if $(WIN32_THREADS), -DILMBASE_FORCE_CXX03=ON) \
        -DOPENEXR_CXX_STANDARD=14 \
        -DILMBASE_INSTALL_PKG_CONFIG=ON \
        -DBUILD_TESTING=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        '$(SOURCE_DIR)/IlmBase'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define cfitsio_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_SHARED_LIBS=ON \
        -DUseCurl=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-cfitsio.exe' \
        `'$(TARGET)-pkg-config' cfitsio --cflags --libs`
endef

# build with CMake.
define hdf5_BUILD
    mkdir '$(BUILD_DIR)/native'
    mkdir '$(BUILD_DIR)/cross'

    # TODO: Do we need to generate H5lib_settings.c and H5Tinit.c on
    # the host system instead?
    cd '$(BUILD_DIR)/native' && cmake \
        -DBUILD_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DONLY_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DBUILD_TESTING=OFF \
        -DHDF5_BUILD_TOOLS=OFF \
        -DHDF5_BUILD_EXAMPLES=OFF \
        -DHDF5_BUILD_HL_LIB=OFF \
        -DHDF5_GENERATE_HEADERS=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)/native' -j '$(JOBS)' gen_hdf5-$(if $(BUILD_STATIC),static,shared)
    cp '$(BUILD_DIR)/native/H5lib_settings.c' '$(BUILD_DIR)/cross'

    # H5_HAVE_IOEO=1 requires WINVER >= 0x600
    cd '$(BUILD_DIR)/cross' && '$(TARGET)-cmake' \
        -DONLY_SHARED_LIBS=$(CMAKE_SHARED_BOOL) \
        -DH5_ENABLE_SHARED_LIB=$(CMAKE_SHARED_BOOL) \
        -DH5_ENABLE_STATIC_LIB=$(CMAKE_STATIC_BOOL) \
        -DH5_PRINTF_LL_WIDTH='"ll"' \
        -DH5_LDOUBLE_TO_LONG_SPECIAL=OFF \
        -DH5_LONG_TO_LDOUBLE_SPECIAL=OFF \
        -DH5_LDOUBLE_TO_LLONG_ACCURATE=ON \
        -DH5_LLONG_TO_LDOUBLE_CORRECT=ON \
        -DH5_DISABLE_SOME_LDOUBLE_CONV=OFF \
        -DH5_NO_ALIGNMENT_RESTRICTIONS=ON \
        -DH5_HAVE_IOEO=1 \
        -DTEST_LFS_WORKS_RUN=0 \
        -DHDF5_ENABLE_THREADSAFE=ON \
        -DHDF5_USE_PREGEN=ON \
        -DHDF5_USE_PREGEN_DIR='$(BUILD_DIR)/native' \
        -DBUILD_TESTING=OFF \
        -DHDF5_BUILD_TOOLS=OFF \
        -DHDF5_BUILD_EXAMPLES=OFF \
        -DHDF5_BUILD_HL_LIB=OFF \
        -DHDF5_GENERATE_HEADERS=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)/cross' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)/cross' -j 1 install

    # setup cmake toolchain
    (echo 'set(HDF5_C_COMPILER_EXECUTABLE $(PREFIX)/bin/$(TARGET)-h5cc)'; \
     echo 'set(HDF5_CXX_COMPILER_EXECUTABLE $(PREFIX)/bin/$(TARGET)-h5c++)'; \
     ) > '$(CMAKE_TOOLCHAIN_DIR)/$(PKG).cmake'
endef
