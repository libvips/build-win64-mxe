$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 3.3
libffi_VERSION  := 3.4.2
libffi_CHECKSUM := 540fb721619a6aba3bdeef7d940d8e9e0e6d2c193595bc243241b77ff9e93620
libffi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libffi-[0-9]*.patch)))
libffi_SUBDIR   := libffi-$(libffi_VERSION)
libffi_FILE     := libffi-$(libffi_VERSION).tar.gz
libffi_URL      := https://github.com/libffi/libffi/releases/download/v$(libffi_VERSION)/$(libffi_FILE)
libffi_URL_2    := https://sourceware.org/pub/libffi/$(libffi_FILE)

# upstream version is 2.42.6
gdk-pixbuf_VERSION  := 2.42.9
gdk-pixbuf_CHECKSUM := 28f7958e7bf29a32d4e963556d241d0a41a6786582ff6a5ad11665e0347fc962
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.9.12
libxml2_VERSION  := 2.10.2
libxml2_CHECKSUM := d240abe6da9c65cb1900dd9bf3a3501ccf88b3c2a1cb98317d03f272dda5b265
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.xz
libxml2_URL      := https://download.gnome.org/sources/libxml2/$(call SHORT_PKG_VERSION,libxml2)/$(libxml2_FILE)

# upstream version is 1.5.2
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.23
matio_CHECKSUM := 9f91eae661df46ea53c311a1b2dcff72051095b023c612d7cbfc09406c9f4d6e
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.12-62
imagemagick_CHECKSUM := 21eb4c5a4f0f9e76f1e67fb6a20f7b1e4374346ed9351bec9898f370d7b2f035
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# alternatively, one could build libvips with GraphicsMagick
# upstream version is 1.3.36
graphicsmagick_VERSION  := 1.3.38
graphicsmagick_CHECKSUM := 8f8c9704ef09b24a3d233b1b8f2e98a10281f196ca6d170c466bad4f89b1a3bb
graphicsmagick_SUBDIR   := GraphicsMagick-$(graphicsmagick_VERSION)
graphicsmagick_FILE     := GraphicsMagick-$(graphicsmagick_VERSION).tar.lz
graphicsmagick_URL      := https://$(SOURCEFORGE_MIRROR)/project/graphicsmagick/graphicsmagick/$(graphicsmagick_VERSION)/$(graphicsmagick_FILE)

# upstream version is 2.40.21
librsvg_VERSION  := 2.55.0
librsvg_CHECKSUM := 6e626c564e354bcd8c384b90f8e4f30b303afa6c1e0cb5cc56ba14900c5db730
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.50.0
pango_VERSION  := 1.50.9
pango_CHECKSUM := 1b636aabf905130d806372136f5e137b6a27f26d47defd9240bf444f6a4fe610
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.11
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.12
fribidi_CHECKSUM := 0cd233f97fc8c67bb3ac27ce8440def5d3ffacf516765b91c2cc654498293495
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 1.2.2
libwebp_VERSION  := 1.2.4
libwebp_CHECKSUM := 7bf5a8a28cc69bcfa8cb214f2c3095703c6b73ac5fba4d5480c205331d9494df
libwebp_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libwebp-[0-9]*.patch)))
libwebp_SUBDIR   := libwebp-$(libwebp_VERSION)
libwebp_FILE     := libwebp-$(libwebp_VERSION).tar.gz
libwebp_URL      := http://downloads.webmproject.org/releases/webp/$(libwebp_FILE)

# upstream version is 2.70.2
glib_VERSION  := 2.73.3
glib_CHECKSUM := df1a2b841667d6b48b2ef6969ebda4328243829f6e45866726f806f90f64eead
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
libgsf_VERSION  := 1.14.50
libgsf_CHECKSUM := 6e6c20d0778339069d583c0d63759d297e817ea10d0d897ebbe965f16e2e8e52
libgsf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libgsf-[0-9]*.patch)))
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# upstream version is 0.6.22
libexif_VERSION  := 0.6.24
libexif_CHECKSUM := d47564c433b733d83b6704c70477e0a4067811d184ec565258ac563d8223f6ae
libexif_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libexif-[0-9]*.patch)))
libexif_GH_CONF  := libexif/libexif/releases,v,,,,.tar.bz2

# upstream version is 1.16.0
cairo_VERSION  := 1.17.6
cairo_CHECKSUM := 90496d135c9ef7612c98f8ee358390cdec0825534573778a896ea021155599d2
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.bz2
cairo_URL      := https://gitlab.freedesktop.org/cairo/cairo/-/archive/$(cairo_VERSION)/$(cairo_FILE)

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := AcademySoftwareFoundation/openexr/tags
openexr_VERSION  := 3.1.5
openexr_CHECKSUM := 93925805c1fc4f8162b35f0ae109c4a75344e6decae5a240afdfce25f8a433ec
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/AcademySoftwareFoundation/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 3410
cfitsio_VERSION  := 4.1.0
cfitsio_CHECKSUM := b367c695d2831958e7166921c3b356d5dfa51b1ecee505b97416ba39d1b6c17a
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

# upstream version is 2.13
# cannot use GH_CONF:
# lcms_GH_CONF  := mm2/Little-CMS,lcms
lcms_VERSION  := 2.13.1
lcms_CHECKSUM := d473e796e7b27c5af01bd6d1552d42b45b43457e7182ce9903f38bb748203b88
lcms_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lcms-[0-9]*.patch)))
lcms_SUBDIR   := lcms2-$(lcms_VERSION)
lcms_FILE     := lcms2-$(lcms_VERSION).tar.gz
lcms_URL      := https://github.com/mm2/Little-CMS/releases/download/lcms$(lcms_VERSION)/$(lcms_FILE)

# upstream version is 3.3.8
fftw_VERSION  := 3.3.10
fftw_CHECKSUM := 56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
fftw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

# upstream version is 22.08.0
poppler_VERSION  := 22.09.0
poppler_CHECKSUM := d7a8f748211359cadb774ba3e18ecda6464b34027045c0648eb30d5852a41e2e
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

# zlib will make libzlib.dll, but we want libz.dll so we must
# patch CMakeLists.txt
zlib_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

## Override sub-dependencies
# libgsf:
#  Removed: bzip2
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
#  Removed: icu4c

libgsf_DEPS             := $(filter-out bzip2 ,$(libgsf_DEPS))
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
harfbuzz_DEPS           := $(filter-out  icu4c,$(harfbuzz_DEPS))

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

# exclude bz2 and gdk-pixbuf
define libgsf_BUILD
    $(SED) -i 's,\ssed\s, $(SED) ,g'           '$(SOURCE_DIR)'/gsf/Makefile.in

    # Allow libtool to statically link against libintl
    # by specifying lt_cv_deplibs_check_method="pass_all"
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-gdk-pixbuf \
        --without-bz2 \
        --with-zlib \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config' \
        $(if $(IS_INTL_DUMMY), lt_cv_deplibs_check_method="pass_all")

    $(MAKE) -C '$(BUILD_DIR)'     -j '$(JOBS)' install-pkgconfigDATA $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)/gsf' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
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
define pixman_BUILD
    # Disable tests and demos
    $(SED) -i "/subdir('test')/{N;d;}" '$(SOURCE_DIR)/meson.build'

    $(MXE_MESON_WRAPPER) \
        -Dopenmp=disabled \
        -Dgtk=disabled \
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

    $(MXE_NINJA) -C '$(BUILD_DIR)' install
endef

# exclude jpeg, tiff dependencies
# build with -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT to avoid a
# horrible hack (we don't target pre-Windows XP, so it should be safe)
define lcms_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib \
        CPPFLAGS='-DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
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
            $(TARGET)-cargo vendor -s '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/library/test/Cargo.toml')

    $(if $(IS_LLVM), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(librsvg_PATCHES))))/librsvg-llvm-mingw.patch \
        # Update expected Cargo SHA256 hashes for the vendored files we have patched
        $(SED) -i 's/f078966ea9ec6f5b003664ad36a7598dadb11179188643ae1adceabbaf7893ab/2b61f22c9caba100e52e84357f857ad12c7b9386c0c18e933e2789e1bd79c14d/' '$(SOURCE_DIR)/vendor/cfg-expr/.cargo-checksum.json'; \
        $(SED) -i 's/0c006642fbbe9fa5372a88cbbbb0bb4b391f635b2bde0c497de10740c1458c5e/54ad858051e051e95df10b867411991ca5f6f36ce66b5fa010655ea0a710d14f/' '$(SOURCE_DIR)/vendor/compiler_builtins/.cargo-checksum.json'; \
        $(SED) -i 's/cb9a830e0d440ed825aa897f268e4ae067204da4ffc162ba963977a4b309007f/2ad9662639d60baf1441bec3eb5db7bd726dbe9ad6b4fe20c25448ccd666131a/' '$(SOURCE_DIR)/vendor/compiler_builtins/.cargo-checksum.json'; \
        $(SED) -i 's/966128476fdf0d3148da21508a27a159ad2d272391e4a3ffbf18008300cca80c/ead5a3b748c9a5fcb145fa2e5cfc8df32f383369b8842fba4272ca3b568109ea/' '$(SOURCE_DIR)/vendor/windows-sys/.cargo-checksum.json'; \
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

# disable the C++ API for now, we don't use it anyway
# build without lzma
define tiff_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-x \
        --disable-cxx \
        --disable-lzma
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

# node-canvas needs a Cairo with SVG support, so compile with -Dpng=enabled
# ensure the FontConfig backend is enabled
# build with -Dzlib=disabled to disable the script, PostScript, PDF and XML surfaces
define cairo_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dfontconfig=enabled \
        -Dfreetype=enabled \
        -Dgl-backend=disabled \
        -Dglesv2=disabled \
        -Dglesv3=disabled \
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
# disable the linker version script on llvm-mingw
# OpenSlide needs --with-xpath
# ImageMagick's internal MSVG parser needs --with-sax1
define libxml2_BUILD
    $(SED) -i 's,`uname`,MinGW,g' '$(1)/xml2-config.in'

    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib='$(PREFIX)/$(TARGET)/lib' \
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
        --without-threads \
        $(if $(IS_LLVM), --disable-ld-version-script)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_CRUFT)
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

    # Build as shared library, since we need `libgobject-2.0-0.dll`
    # and `libglib-2.0-0.dll` for the language bindings.
    # Enable networking to allow gvdb to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 $(MXE_MESON_WRAPPER) \
        --default-library=shared \
        --force-fallback-for=gvdb \
        -Dnls=disabled \
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
