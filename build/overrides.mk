$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 3.3
libffi_VERSION  := 3.4.4
libffi_CHECKSUM := d66c56ad259a82cf2a9dfc408b32bf5da52371500b84745f7fb8b645712df676
libffi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libffi-[0-9]*.patch)))
libffi_SUBDIR   := libffi-$(libffi_VERSION)
libffi_FILE     := libffi-$(libffi_VERSION).tar.gz
libffi_URL      := https://github.com/libffi/libffi/releases/download/v$(libffi_VERSION)/$(libffi_FILE)
libffi_URL_2    := https://sourceware.org/pub/libffi/$(libffi_FILE)

# upstream version is 2.42.6
gdk-pixbuf_VERSION  := 2.42.10
gdk-pixbuf_CHECKSUM := ee9b6c75d13ba096907a2e3c6b27b61bcd17f5c7ebeab5a5b439d2f2e39fe44b
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.11.1
libxml2_VERSION  := 2.11.5
libxml2_CHECKSUM := 3727b078c360ec69fa869de14bd6f75d7ee8d36987b071e6928d4720a28df3a6
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.xz
libxml2_URL      := https://download.gnome.org/sources/libxml2/$(call SHORT_PKG_VERSION,libxml2)/$(libxml2_FILE)

# upstream version is 3.4.0
libarchive_VERSION  := 3.7.2
libarchive_CHECKSUM := 04357661e6717b6941682cde02ad741ae4819c67a260593dfb2431861b251acb
libarchive_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libarchive-[0-9]*.patch)))
libarchive_SUBDIR   := libarchive-$(libarchive_VERSION)
libarchive_FILE     := libarchive-$(libarchive_VERSION).tar.xz
libarchive_URL      := https://github.com/libarchive/libarchive/releases/download/v$(libarchive_VERSION)/$(libarchive_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.12-93
imagemagick_CHECKSUM := a44fff9597e5ef4076022e403e62d0e1a3bc5c3218fd424b1c305a14dfd2ee4d
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# alternatively, one could build libvips with GraphicsMagick
# upstream version is 1.3.38
graphicsmagick_VERSION  := 1.3.40
graphicsmagick_CHECKSUM := 45e4da103e8106f1b751d73526ce41173db418bd56508a1c48fbb0ca139c9441
graphicsmagick_SUBDIR   := GraphicsMagick-$(graphicsmagick_VERSION)
graphicsmagick_FILE     := GraphicsMagick-$(graphicsmagick_VERSION).tar.lz
graphicsmagick_URL      := https://$(SOURCEFORGE_MIRROR)/project/graphicsmagick/graphicsmagick/$(graphicsmagick_VERSION)/$(graphicsmagick_FILE)

# upstream version is 2.40.21
librsvg_VERSION  := 2.57.0
librsvg_CHECKSUM := 335fe2e0c2cbf1b7bf0668651224a23e135451f0b1793cd813649be2bffa74e8
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.0.12
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.13
fribidi_CHECKSUM := 7fa16c80c81bd622f7b198d31356da139cc318a63fc7761217af4130903f54a2
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 1.3.1
libwebp_VERSION  := 1.3.2
libwebp_CHECKSUM := 2a499607df669e40258e53d0ade8035ba4ec0175244869d1025d460562aa09b4
libwebp_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libwebp-[0-9]*.patch)))
libwebp_SUBDIR   := libwebp-$(libwebp_VERSION)
libwebp_FILE     := libwebp-$(libwebp_VERSION).tar.gz
libwebp_URL      := http://downloads.webmproject.org/releases/webp/$(libwebp_FILE)

# upstream version is 2.70.2
glib_VERSION  := 2.78.0
glib_CHECKSUM := 44eaab8b720877ce303c5540b657b126f12dc94972d9880b52959f43fb537b30
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 0.6.22
libexif_VERSION  := 0.6.24
libexif_CHECKSUM := d47564c433b733d83b6704c70477e0a4067811d184ec565258ac563d8223f6ae
libexif_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libexif-[0-9]*.patch)))
libexif_GH_CONF  := libexif/libexif/releases,v,,,,.tar.bz2

# upstream version is 1.16.0
cairo_VERSION  := 1.17.8
cairo_CHECKSUM := 5b10c8892d1b58d70d3f0ba5b47863a061262fa56b9dc7944161f8c8b783bc64
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := https://cairographics.org/snapshots/$(cairo_FILE)

# upstream version is 4.5.1
tiff_VERSION  := 4.6.0
tiff_CHECKSUM := e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2
tiff_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/tiff-[0-9]*.patch)))
tiff_SUBDIR   := tiff-$(tiff_VERSION)
tiff_FILE     := tiff-$(tiff_VERSION).tar.xz
tiff_URL      := https://download.osgeo.org/libtiff/$(tiff_FILE)

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

# upstream version is 3410
cfitsio_VERSION  := 4.3.0
cfitsio_CHECKSUM := fdadc01d09cf9f54253802c5ec87eb10de51ce4130411415ae88c30940621b8b
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio-$(cfitsio_VERSION)
cfitsio_FILE     := cfitsio-$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)
cfitsio_URL_2    := https://mirrorservice.org/sites/distfiles.macports.org/cfitsio/$(cfitsio_FILE)

# upstream version is 0.33.6
pixman_VERSION  := 0.42.2
pixman_CHECKSUM := ea1480efada2fd948bc75366f7c349e1c96d3297d09a3fe62626e38e234a625e
pixman_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pixman-[0-9]*.patch)))
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# upstream version is 2.13.1
freetype_VERSION  := 2.13.2
freetype_CHECKSUM := 12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d
freetype_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/freetype-[0-9]*.patch)))
freetype_SUBDIR   := freetype-$(freetype_VERSION)
freetype_FILE     := freetype-$(freetype_VERSION).tar.xz
freetype_URL      := https://$(SOURCEFORGE_MIRROR)/project/freetype/freetype2/$(freetype_VERSION)/$(freetype_FILE)

# upstream version is 2.13.1
freetype-bootstrap_VERSION  := $(freetype_VERSION)
freetype-bootstrap_CHECKSUM := $(freetype_CHECKSUM)
freetype-bootstrap_PATCHES  := $(freetype_PATCHES)
freetype-bootstrap_SUBDIR   := $(freetype_SUBDIR)
freetype-bootstrap_FILE     := $(freetype_FILE)
freetype-bootstrap_URL      := $(freetype_URL)

# upstream version is 7.3.0
harfbuzz_VERSION  := 8.2.0
harfbuzz_CHECKSUM := 8cb7117a62f42d5ad25d4a697e1bbfc65933b3eed2ee7f247203c79c9f1b514c
harfbuzz_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
harfbuzz_GH_CONF  := harfbuzz/harfbuzz/releases,,,,,.tar.xz

# upstream version is 1.2.13
zlib_VERSION  := 1.3
zlib_CHECKSUM := 8a9ba2898e1d0d774eca6ba5b4627a11e5588ba85c8851336eb38de4683050a7
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))
zlib_GH_CONF  := madler/zlib/releases,v,,,,.tar.xz

# upstream version is 3.3.8
fftw_VERSION  := 3.3.10
fftw_CHECKSUM := 56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
fftw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

# upstream version is 23.07.0
poppler_VERSION  := 23.09.0
poppler_CHECKSUM := 80d1d44dd8bdf4ac1a47d56c5065075eb9991790974b1ed7d14b972acde88e55
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))
poppler_SUBDIR   := poppler-$(poppler_VERSION)
poppler_FILE     := poppler-$(poppler_VERSION).tar.xz
poppler_URL      := https://poppler.freedesktop.org/$(poppler_FILE)

# upstream version is 2.14.02
nasm_VERSION  := 2.15.05
nasm_CHECKSUM := 3caf6729c1073bf96629b57cee31eeb54f4f8129b01902c73428836550b30a3f
nasm_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/nasm-[0-9]*.patch)))
nasm_SUBDIR   := nasm-$(nasm_VERSION)
nasm_FILE     := nasm-$(nasm_VERSION).tar.xz
nasm_URL      := https://www.nasm.us/pub/nasm/releasebuilds/$(nasm_VERSION)/$(nasm_FILE)
nasm_URL_2    := https://sources.voidlinux.org/nasm-$(nasm_VERSION)/$(nasm_FILE)

# upstream version is 11.0.0
# Update MinGW-w64 to 8a397f1
# https://github.com/mingw-w64/mingw-w64/tarball/8a397f16736a140ab523e308b159ec9265cf6135
mingw-w64_VERSION  := 8a397f1
mingw-w64_CHECKSUM := aa14db1839c567b6c6f493d6d46ed49032901a8a5fc8b4b880373cdc0572dd6d
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mingw-w64-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mingw-w64/mingw-w64/tarball/$(mingw-w64_VERSION)/$(mingw-w64_FILE)

## Patches that we override with our own

freetype_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/freetype-[0-9]*.patch)))
freetype-bootstrap_PATCHES := $(freetype_PATCHES)
libjpeg-turbo_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))
harfbuzz_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
libxml2_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
poppler_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))
meson_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/meson-[0-9]*.patch)))
mingw-w64_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
fontconfig_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fontconfig-[0-9]*.patch)))
lcms_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lcms-[0-9]*.patch)))

# zlib will make libzlib.dll, but we want libz.dll so we must
# patch CMakeLists.txt
zlib_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

## Override sub-dependencies
# freetype:
#  Added: meson-wrapper
#  Removed: bzip2
# freetype-bootstrap:
#  Added: meson-wrapper
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
#  Added: libxml2, rust
#  Removed: libcroco, libgsf
# Cairo:
#  Added: meson-wrapper
#  Removed: lzo
# matio:
#  Removed: hdf5
# libjpeg-turbo:
#  Replaced: yasm with $(BUILD)~nasm
# libxml2:
#  Removed: xz
# Fontconfig:
#  Added: meson-wrapper
#  Removed: gettext
# CFITSIO:
#  Added: zlib
# libexif:
#  Removed: gettext
# Pixman:
#  Added: meson-wrapper
# HarfBuzz:
#  Removed: brotli icu4c
# libarchive:
#  Removed: bzip2 libiconv libxml2 nettle openssl xz

freetype_DEPS           := $(subst bzip2,meson-wrapper,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst bzip2,meson-wrapper,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc meson-wrapper gettext libffi zlib
gdk-pixbuf_DEPS         := cc meson-wrapper glib libjpeg-turbo libpng tiff
lcms_DEPS               := $(filter-out jpeg tiff ,$(lcms_DEPS))
tiff_DEPS               := cc libjpeg-turbo libwebp zlib
imagemagick_DEPS        := cc libxml2 openjpeg lcms libjpeg-turbo
graphicsmagick_DEPS     := $(imagemagick_DEPS)
openexr_DEPS            := cc imath zlib
poppler_DEPS            := cc cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
librsvg_DEPS            := $(filter-out libcroco libgsf ,$(librsvg_DEPS)) libxml2 rust
cairo_DEPS              := cc meson-wrapper fontconfig freetype-bootstrap glib libpng pixman
matio_DEPS              := $(filter-out hdf5 ,$(matio_DEPS))
libjpeg-turbo_DEPS      := $(subst yasm,$(BUILD)~nasm,$(libjpeg-turbo_DEPS))
libxml2_DEPS            := $(filter-out xz ,$(libxml2_DEPS))
fontconfig_DEPS         := cc meson-wrapper expat freetype-bootstrap
cfitsio_DEPS            := cc zlib
libexif_DEPS            := $(filter-out  gettext,$(libexif_DEPS))
pixman_DEPS             := cc meson-wrapper libpng
harfbuzz_DEPS           := cc meson-wrapper cairo freetype-bootstrap glib
libarchive_DEPS         := cc zlib

## Override build scripts

# Unexport target specific compiler / linker flags
define gendef_BUILD
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/mingw-w64-tools/gendef/configure' \
        CFLAGS='-Wno-implicit-fallthrough' \
        --host='$(BUILD)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)/$(TARGET)' \
        --target='$(TARGET)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)
endef

define pkgconf_BUILD_$(BUILD)
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    cd '$(SOURCE_DIR)' && ./autogen.sh
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        --prefix='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define nasm_BUILD_$(BUILD)
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    # build nasm compiler
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define ninja_BUILD_$(BUILD)
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    '$(TARGET)-cmake' -S '$(SOURCE_DIR)' -B '$(BUILD_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -DBUILD_TESTING=OFF
    '$(TARGET)-cmake' --build '$(BUILD_DIR)' -j '$(JOBS)'
    '$(TARGET)-cmake' --install '$(BUILD_DIR)'
endef

define widl_BUILD
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/mingw-w64-tools/widl/configure' \
        --host='$(BUILD)' \
        --build='$(BUILD)' \
        --prefix='$(PREFIX)' \
        --target='$(TARGET)' \
        $(if $(IS_LLVM), --with-widl-includedir='$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/include')
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # create cmake file
    mkdir -p '$(CMAKE_TOOLCHAIN_DIR)'
    echo 'set(CMAKE_WIDL $(PREFIX)/bin/$(TARGET)-$(PKG) CACHE PATH "widl executable")' \
    > '$(CMAKE_TOOLCHAIN_DIR)/$(PKG).cmake'
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
        $(if $(IS_LLVM), --disable-symvers)

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
        -Dbuiltin_loaders='jpeg,png,tiff' \
        -Dintrospection=disabled \
        -Dman=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build pixman with the Meson build system
# build with -Da64-neon=disabled, see:
# https://gitlab.freedesktop.org/pixman/pixman/-/issues/66
define pixman_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dopenmp=disabled \
        -Dgtk=disabled \
        -Dtests=disabled \
        -Da64-neon=disabled \
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
    $(MXE_MESON_WRAPPER) \
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
        --disable-deprecated
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
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
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER='$(PREFIX)/$(BUILD)/bin/nasm' \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
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
    # Disable utils, examples, tests and tools
    $(SED) -i "/subdir('utils')/{N;N;N;d;}" '$(SOURCE_DIR)/meson.build'

    $(MXE_MESON_WRAPPER) \
        -Dintrospection=disabled \
        -Dfontconfig=enabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# compile with the Rust toolchain
define librsvg_BUILD
    # Allow building vendored sources with `-Zbuild-std`, see:
    # https://github.com/rust-lang/wg-cargo-std-aware/issues/23#issuecomment-720455524
    $(if $(IS_LLVM), \
        cd '$(SOURCE_DIR)' && \
            MXE_ENABLE_NETWORK=1 \
            $(TARGET)-cargo vendor -s '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/library/sysroot/Cargo.toml')

    $(if $(IS_LLVM), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(librsvg_PATCHES))))/librsvg-llvm-mingw.patch \
        # Update expected Cargo SHA256 hashes for the vendored files we have patched
        $(SED) -i 's/1cb3a78f27813219776604dc99a86b95c3c4649c34a06f840440433ffb178c1d/930123760293dc184dbabc209c73cbfc079af5ca3eaabd76a06316bafbd399a3/' '$(SOURCE_DIR)/vendor/cfg-expr/.cargo-checksum.json'; \
        $(SED) -i 's/2791024558e8884c3b755c4fb1e019ecce615f2849cd3f38866cb7fdc817f408/d8d4c9529b50f809b7352a257751600047bfe0e420e2fd98abf8a77d9451ad40/' '$(SOURCE_DIR)/vendor/compiler_builtins/.cargo-checksum.json'; \
        $(SED) -i 's/8bf710288f88cfbf67e510f68abbb5a4f7173d2ea9ef32f98d594935fc051641/891c080ebd853786846af1987ca5bdb92485a792d3ec7281cf20ddaef94c9b21/' '$(SOURCE_DIR)/vendor/compiler_builtins/.cargo-checksum.json'; \
        $(SED) -i 's/01bdacaccadd2b9b69183f9b5a28d010d3454d886841432f51aa79cb274c24ec/014ceac5eddbc6492e09f1a1f1bbc6dc65bb061450df613f1b3e32c00387e1df/' '$(SOURCE_DIR)/vendor/windows-sys/.cargo-checksum.json'; \
        $(SED) -i 's/e990dd3ef1561f99521c4129a261a38130c823addf52f46b341fe99960d4cb74/b819750a2bb403807ebabb845b88707e81359b1c01782424dcb07f44acd001de/' '$(SOURCE_DIR)/vendor/windows-sys/.cargo-checksum.json'; \
        # Install Cargo config
        $(INSTALL) -d '$(SOURCE_DIR)/.cargo'
        (echo '[source.crates-io]'; \
         echo 'registry = "https://github.com/rust-lang/crates.io-index"'; \
         echo 'replace-with = "vendored-sources"'; \
         echo '[source.vendored-sources]'; \
         echo 'directory = "./vendor"';) \
                 > '$(SOURCE_DIR)/.cargo/config')

    # Allow libtool to statically link against libintl
    # by specifying lt_cv_deplibs_check_method="pass_all"
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-introspection \
        RUST_TARGET='$(PROCESSOR)-pc-windows-gnu$(if $(IS_LLVM),llvm)' \
        CARGO='$(TARGET)-cargo' \
        RUSTC='$(TARGET)-rustc' \
        $(if $(IS_INTL_DUMMY), lt_cv_deplibs_check_method="pass_all")

    $(if $(IS_GCC), MXE_ENABLE_NETWORK=1) $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_SCRIPTS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) bin_SCRIPTS=
endef

# compile with CMake
define poppler_BUILD
    $(if $(WIN32_THREADS), \
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
        -DENABLE_BOOST=OFF \
        -DENABLE_CPP=OFF \
        -DBUILD_GTK_TESTS=OFF \
        -DENABLE_UTILS=OFF \
        -DENABLE_QT5=OFF \
        -DENABLE_LIBCURL=OFF \
        -DBUILD_QT5_TESTS=OFF \
        -DBUILD_QT6_TESTS=OFF \
        -DBUILD_CPP_TESTS=OFF \
        -DBUILD_MANUAL_TESTS=OFF \
        -DENABLE_GTK_DOC=OFF \
        $(if $(WIN32_THREADS), -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -I$(PREFIX)/$(TARGET)/include/mingw-std-threads') \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

# the zlib configure is a bit basic, so we'll use cmake
define zlib_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DSKIP_BUILD_EXAMPLES=ON \
        -DINSTALL_PKGCONFIG_DIR='$(PREFIX)/$(TARGET)/lib/pkgconfig' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
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
        --disable-zstd
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
endef

# disable unneeded loaders
define libwebp_BUILD
    # When targeting Armv7 we need to build without `-gcodeview`:
    # `fatal error: error in backend: unknown codeview register D1_D2`
    # FIXME(kleisauke): https://github.com/llvm/llvm-project/issues/64278
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gl \
        --disable-sdl \
        --disable-png \
        --disable-jpeg \
        --disable-tiff \
        --disable-gif \
        --enable-libwebpmux \
        --enable-libwebpdemux \
        $(if $(call seq,armv7,$(PROCESSOR)), CFLAGS='')
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# node-canvas needs a Cairo with SVG support, so compile with -Dpng=enabled
# ensure the FontConfig backend is enabled
# build with -Dzlib=disabled to disable the script, PostScript, PDF and XML surfaces
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
        -Dxml=disabled \
        -Dzlib=disabled \
        -Dtests=disabled \
        -Dgtk2-utils=disabled \
        -Dglib=enabled \
        -Dspectre=disabled \
        -Dsymbol-lookup=disabled \
        -Dgtk_doc=false \
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

# build a minimal libxml2, see: https://github.com/lovell/sharp-libvips/pull/92
# OpenSlide needs --with-xpath
# ImageMagick's internal MSVG parser needs --with-sax1
define libxml2_BUILD
    $(SED) -i 's,`uname`,MinGW,g' '$(1)/xml2-config.in'

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib='$(PREFIX)/$(TARGET)' \
        --with-minimum \
        --with-reader \
        --with-writer \
        --with-valid \
        --with-http \
        --with-tree \
        $(if $(findstring .all,$(TARGET)), \
            --with-xpath \
            --with-sax1) \
        --without-lzma \
        --without-debug \
        --without-iconv \
        --without-python \
        --without-threads
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
    ln -sf '$(PREFIX)/$(TARGET)/bin/xml2-config' '$(PREFIX)/bin/$(TARGET)-xml2-config'
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
        $(if $(BUILD_STATIC), CFLAGS='-DLIBARCHIVE_STATIC')
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
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

    # Build as shared library, since we need `libgobject-2.0-0.dll`
    # and `libglib-2.0-0.dll` for the language bindings.
    # Enable networking to allow gvdb to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 $(MXE_MESON_WRAPPER) \
        --default-library=shared \
        --force-fallback-for=gvdb \
        -Dnls=disabled \
        -Dtests=false \
        -Dglib_assert=false \
        -Dglib_checks=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef

# build with CMake.
define openexr_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DOPENEXR_INSTALL_PKG_CONFIG=ON \
        -DOPENEXR_ENABLE_THREADING=$(if $(WIN32_THREADS),OFF,ON) \
        -DOPENEXR_INSTALL_TOOLS=OFF \
        -DOPENEXR_BUILD_TOOLS=OFF \
        -DBUILD_TESTING=OFF \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef

define cfitsio_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_SHARED_LIBS=ON \
        -DUSE_CURL=OFF \
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
