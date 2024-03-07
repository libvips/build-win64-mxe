$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 3.3
libffi_VERSION  := 3.4.6
libffi_CHECKSUM := b0dea9df23c863a7a50e825440f3ebffabd65df1497108e5d437747843895a4e
libffi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libffi-[0-9]*.patch)))
libffi_SUBDIR   := libffi-$(libffi_VERSION)
libffi_FILE     := libffi-$(libffi_VERSION).tar.gz
libffi_URL      := https://github.com/libffi/libffi/releases/download/v$(libffi_VERSION)/$(libffi_FILE)
libffi_URL_2    := https://sourceware.org/pub/libffi/$(libffi_FILE)

# upstream version is 2.42.6
# gdk-pixbuf is still used by OpenSlide and the C API of librsvg
gdk-pixbuf_VERSION  := 2.42.10
gdk-pixbuf_CHECKSUM := ee9b6c75d13ba096907a2e3c6b27b61bcd17f5c7ebeab5a5b439d2f2e39fe44b
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.11.1
libxml2_VERSION  := 2.12.5
libxml2_CHECKSUM := a972796696afd38073e0f59c283c3a2f5a560b5268b4babc391b286166526b21
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.xz
libxml2_URL      := https://download.gnome.org/sources/libxml2/$(call SHORT_PKG_VERSION,libxml2)/$(libxml2_FILE)

# upstream version is 1.5.23
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.26
matio_CHECKSUM := 06352c6a34b2e001b5bd5e748cc405683c88ec71b1098dcf3561a4859c33f44f
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.xz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 3.4.0
libarchive_VERSION  := 3.7.2
libarchive_CHECKSUM := 04357661e6717b6941682cde02ad741ae4819c67a260593dfb2431861b251acb
libarchive_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libarchive-[0-9]*.patch)))
libarchive_SUBDIR   := libarchive-$(libarchive_VERSION)
libarchive_FILE     := libarchive-$(libarchive_VERSION).tar.xz
libarchive_URL      := https://github.com/libarchive/libarchive/releases/download/v$(libarchive_VERSION)/$(libarchive_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.13-7
imagemagick_CHECKSUM := b88e4471322eba0140f0a53bf3af9852e90102cf74c58639a802fdb3e21b1646
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
librsvg_VERSION  := 2.57.91
librsvg_CHECKSUM := e0f9346258ba1c1299aee8abd7b0218ab2ef45fa83bb078a636c1ebb2ecdb6b2
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.51.0
pango_VERSION  := 1.52.1
pango_CHECKSUM := 58728a0a2d86f60761208df9493033d18ecb2497abac80ee1a274ad0c6e55f0f
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.12
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.13
fribidi_CHECKSUM := 7fa16c80c81bd622f7b198d31356da139cc318a63fc7761217af4130903f54a2
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 2.70.2
glib_VERSION  := 2.79.3
glib_CHECKSUM := 00d1a313677ed5f5c5e6f7a77ca66e31cf7aa1e3d6b92b6041a16d7a024580c6
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 2.6.0
expat_VERSION  := 2.6.1
expat_CHECKSUM := 0c00d2760ad12efef6e26efc8b363c8eb28eb8c8de719e46d5bb67b40ba904a3
expat_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/expat-[0-9]*.patch)))
expat_SUBDIR   := expat-$(expat_VERSION)
expat_FILE     := expat-$(expat_VERSION).tar.xz
expat_URL      := https://github.com/libexpat/libexpat/releases/download/R_$(subst .,_,$(expat_VERSION))/$(expat_FILE)

# upstream version is 0.6.22
libexif_VERSION  := 0.6.24
libexif_CHECKSUM := d47564c433b733d83b6704c70477e0a4067811d184ec565258ac563d8223f6ae
libexif_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libexif-[0-9]*.patch)))
libexif_GH_CONF  := libexif/libexif/releases,v,,,,.tar.bz2

# upstream version is 1.16.0
cairo_VERSION  := 1.18.0
cairo_CHECKSUM := 243a0736b978a33dee29f9cca7521733b78a65b5418206fef7bd1c3d4cf10b64
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := https://cairographics.org/releases/$(cairo_FILE)

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
cfitsio_VERSION  := 4.4.0
cfitsio_CHECKSUM := 95900cf95ae760839e7cb9678a7b2fad0858d6ac12234f934bd1cb6bfc246ba9
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio-$(cfitsio_VERSION)
cfitsio_FILE     := cfitsio-$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)
cfitsio_URL_2    := https://mirrorservice.org/sites/distfiles.macports.org/cfitsio/$(cfitsio_FILE)

# upstream version is 0.33.6
pixman_VERSION  := 0.43.4
pixman_CHECKSUM := a0624db90180c7ddb79fc7a9151093dc37c646d8c38d3f232f767cf64b85a226
pixman_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pixman-[0-9]*.patch)))
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# upstream version is 7.3.0
harfbuzz_VERSION  := 8.3.0
harfbuzz_CHECKSUM := 109501eaeb8bde3eadb25fab4164e993fbace29c3d775bcaa1c1e58e2f15f847
harfbuzz_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/harfbuzz-[0-9]*.patch)))
harfbuzz_GH_CONF  := harfbuzz/harfbuzz/releases,,,,,.tar.xz

# upstream version is 3.3.8
fftw_VERSION  := 3.3.10
fftw_CHECKSUM := 56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
fftw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

# upstream version is 2.5.0
openjpeg_VERSION  := 2.5.2
openjpeg_CHECKSUM := 90e3896fed910c376aaf79cdd98bdfdaf98c6472efd8e1debf0a854938cbda6a
openjpeg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openjpeg-[0-9]*.patch)))
openjpeg_GH_CONF  := uclouvain/openjpeg/tags,v

# upstream version is 23.07.0
poppler_VERSION  := 24.03.0
poppler_CHECKSUM := bafbf0db5713dec25b5d16eb2cd87e4a62351cdc40f050c3937cd8dd6882d446
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

# upstream version is 11.0.1
# Update MinGW-w64 to 7ea930b
# https://github.com/mingw-w64/mingw-w64/tarball/7ea930ba381ace6f19f7cfa59596f6fe49949aa6
mingw-w64_VERSION  := 7ea930b
mingw-w64_CHECKSUM := 3726aa11c30b0587ab3fe015c7abcd75bb7627b45d05d70b65859a9969c0a6d1
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
#  Removed: brotli, bzip2
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
#  Removed: brotli, icu4c
# libarchive:
#  Removed: bzip2, libiconv, libxml2, nettle, openssl, xz

freetype_DEPS           := $(subst brotli bzip2,meson-wrapper,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(subst brotli bzip2,meson-wrapper,$(freetype-bootstrap_DEPS))
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
    $(eval export CFLAGS += -O3)

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
        $(SED) -i 's/6ff27ce632a988dd9bcf083dbaa02615254ff29f3e82252539b04f0eb3c629ba/4e83c7139d3bee1826c1f430f57ea39ac099d245d2ca352046b4c448c386078a/' '$(SOURCE_DIR)/vendor/cfg-expr/.cargo-checksum.json'; \
        $(SED) -i 's/85f31d450b44d1f9e329e72a46d181a22e2933593407eeaaebb120453f82757f/30bd0d4dab0d3ca6a0dad131fec3b93bf336913e300c0a750515e8a1c1a5de70/' '$(SOURCE_DIR)/vendor/compiler_builtins/.cargo-checksum.json'; \
        $(SED) -i 's/204bc39a8213167dcab8dd273c57e5fae3afbac8fa3887dbe43ad082d55446e4/0e8c4e6440c5377f487918f16a8ea80aae53fa4d47e495a9e9c0119b575db0ab/' '$(SOURCE_DIR)/vendor/windows-sys/.cargo-checksum.json'; \
        # Install Cargo config
        $(INSTALL) -d '$(SOURCE_DIR)/.cargo'
        (echo '[source.crates-io]'; \
         echo 'registry = "https://github.com/rust-lang/crates.io-index"'; \
         echo 'replace-with = "vendored-sources"'; \
         echo '[source.vendored-sources]'; \
         echo 'directory = "./vendor"';) \
                 > '$(SOURCE_DIR)/.cargo/config.toml')

    # Allow libtool to statically link against libintl
    # by specifying lt_cv_deplibs_check_method="pass_all"
    # Need to link against synchronization after PR:
    # https://github.com/rust-lang/rust/pull/121317
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-introspection \
        RUST_TARGET='$(PROCESSOR)-pc-windows-gnu$(if $(IS_LLVM),llvm)' \
        CARGO='$(TARGET)-cargo' \
        RUSTC='$(TARGET)-rustc' \
        $(if $(IS_INTL_DUMMY), lt_cv_deplibs_check_method="pass_all") \
        LIBS='-lsynchronization'

    $(if $(IS_GCC), MXE_ENABLE_NETWORK=1) $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_SCRIPTS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) bin_SCRIPTS=
endef

# compile with CMake
define poppler_BUILD
    $(if $(WIN32_THREADS), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(poppler_PATCHES))))/poppler-mingw-std-threads.patch)

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
    $(if $(findstring .ffi,$(TARGET)), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(glib_PATCHES))))/glib-static.patch)

    # Build as shared library when `--with-ffi-compat` is passed, since we
    # need `libgobject-2.0-0.dll` and `libglib-2.0-0.dll` for these bindings.
    # Enable networking to allow gvdb to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 $(MXE_MESON_WRAPPER) \
        $(if $(findstring .ffi,$(TARGET)), --default-library=shared) \
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
