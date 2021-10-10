$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# upstream version is 3.2.1
libffi_VERSION  := 3.4.2
libffi_CHECKSUM := 540fb721619a6aba3bdeef7d940d8e9e0e6d2c193595bc243241b77ff9e93620
libffi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libffi-[0-9]*.patch)))
libffi_SUBDIR   := libffi-$(libffi_VERSION)
libffi_FILE     := libffi-$(libffi_VERSION).tar.gz
libffi_URL      := https://github.com/libffi/libffi/releases/download/v$(libffi_VERSION)/$(libffi_FILE)
libffi_URL_2    := https://sourceware.org/pub/libffi/$(libffi_FILE)

# upstream version is 2.32.3
gdk-pixbuf_VERSION  := 2.42.6
gdk-pixbuf_CHECKSUM := c4a6b75b7ed8f58ca48da830b9fa00ed96d668d3ab4b1f723dcf902f78bde77f
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.9.10
libxml2_VERSION  := 2.9.12
libxml2_CHECKSUM := c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.gz
libxml2_URL      := http://xmlsoft.org/sources/$(libxml2_FILE)
libxml2_URL_2    := https://ftp.osuosl.org/pub/blfs/conglomeration/libxml2/$(libxml2_FILE)

# upstream version is 1.5.2
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.21
matio_CHECKSUM := 21809177e55839e7c94dada744ee55c1dea7d757ddaab89605776d50122fb065
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.12-25
imagemagick_CHECKSUM := a6de8acc96c48a3934b1389f051efbacc1536900362c22ad0c23d8756deaae9a
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# upstream version is 2.40.5
librsvg_VERSION  := 2.52.1
librsvg_CHECKSUM := 949dffcb0414865409e17a6c89ae30bc8bb014a51fba5186f73d1a46c6c5ccde
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.49.1
pango_CHECKSUM := c4266dc06c01bf0133d3815502426d209de5ea7abd895899e73e7edebaf48f6f
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.8
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.11
fribidi_CHECKSUM := 30f93e9c63ee627d1a2cedcf59ac34d45bf30240982f99e44c6e015466b4e73d
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.xz
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.70.0
glib_CHECKSUM := 200d7df811c5ba634afbf109f14bb40ba7fde670e89389885da14e27c0840742
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
cairo_VERSION  := 1.17.4
cairo_CHECKSUM := 74b24c1ed436bbe87499179a3b27c43f4143b8676d8ad237a6fa787401959705
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := http://cairographics.org/snapshots/$(cairo_FILE)

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := AcademySoftwareFoundation/openexr/tags
openexr_VERSION  := 3.1.2
openexr_CHECKSUM := f5c8f148e8f972e76b47e802aada1c59ef1837f0a9259c6677756e7cd347640f
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/AcademySoftwareFoundation/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 3410
cfitsio_VERSION  := 4.0.0
cfitsio_CHECKSUM := b2a8efba0b9f86d3e1bd619f662a476ec18112b4f27cc441cc680a4e3777425e
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
fontconfig_VERSION  := 2.13.94
fontconfig_CHECKSUM := a5f052cb73fd479ffb7b697980510903b563bbb55b8f7a2b001fcfb94026003c
fontconfig_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fontconfig-[0-9]*.patch)))
fontconfig_SUBDIR   := fontconfig-$(fontconfig_VERSION)
fontconfig_FILE     := fontconfig-$(fontconfig_VERSION).tar.xz
fontconfig_URL      := https://www.freedesktop.org/software/fontconfig/release/$(fontconfig_FILE)

# upstream version is 3.3.8
fftw_VERSION  := 3.3.10
fftw_CHECKSUM := 56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
fftw_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fftw-[0-9]*.patch)))
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

# upstream version is 21.06.1
poppler_VERSION  := 21.10.0
poppler_CHECKSUM := 964b5b16290fbec3fae57c2a5bcdea49bb0736bd750c3a3711c47995c9efc394
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

# upstream version is 9.0.0
# Update MinGW-w64 to acdc7ad
# https://github.com/mingw-w64/mingw-w64/tarball/acdc7adc9c4dbc7517dac13bce21409229316248
mingw-w64_VERSION  := acdc7ad
mingw-w64_CHECKSUM := 76627885148d9707fb721ce7d87c492695c7d5c2f342e285e8bee5abd7646fb4
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mingw-w64-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mingw-w64/mingw-w64/tarball/$(mingw-w64_VERSION)/$(mingw-w64_FILE)

## Patches that we override with our own

freetype_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/freetype-[0-9]*.patch)))
freetype-bootstrap_PATCHES := $(freetype_PATCHES)
libjpeg-turbo_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))
tiff_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/tiff-[0-9]*.patch)))
lcms_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lcms-[0-9]*.patch)))

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
#  Added: libjpeg-turbo, lcms
#  Removed: curl, qtbase, libwebp
# librsvg:
#  Added: libxml2, rust
#  Removed: libcroco, libgsf
# Cairo:
#  Removed: lzo
# matio:
#  Removed: hdf5
# libjpeg-turbo:
#  Replaced: yasm with $(BUILD)~nasm
# libxml2:
#  Removed: xz
# Fontconfig:
#  Removed: gettext
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
openexr_DEPS            := cc imath zlib
pango_DEPS              := $(pango_DEPS) fribidi
poppler_DEPS            := cc cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
librsvg_DEPS            := $(filter-out libcroco libgsf ,$(librsvg_DEPS)) libxml2 rust
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman zlib
matio_DEPS              := $(filter-out hdf5 ,$(matio_DEPS))
libjpeg-turbo_DEPS      := $(subst yasm,$(BUILD)~nasm,$(libjpeg-turbo_DEPS))
libxml2_DEPS            := $(filter-out xz ,$(libxml2_DEPS))
fontconfig_DEPS         := $(filter-out  gettext,$(fontconfig_DEPS))
cfitsio_DEPS            := cc zlib

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

# icu will pull in standard linux headers, which we don't want,
# build with Meson.
define harfbuzz_BUILD
    '$(TARGET)-meson' \
        -Dicu=disabled \
        -Dtests=disabled \
        -Dintrospection=disabled \
        -Ddocs=disabled \
        -Dbenchmark=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# build with the Meson build system
# build without bzip2 and brotli
define freetype_BUILD_COMMON
    '$(TARGET)-meson' \
        -Dharfbuzz=enabled \
        -Dpng=enabled \
        -Dzlib=enabled \
        -Dbrotli=disabled \
        -Dbzip2=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
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

    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-gdk-pixbuf \
        --without-bz2 \
        --with-zlib \
        --disable-nls \
        --without-libiconv-prefix \
        --without-libintl-prefix \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config'
    $(MAKE) -C '$(BUILD_DIR)'     -j '$(JOBS)' install-pkgconfigDATA $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)/gsf' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# build with the Meson build system
define gdk-pixbuf_BUILD
    '$(TARGET)-meson' \
        -Dbuiltin_loaders='jpeg,png,tiff' \
        -Dintrospection=disabled \
        $(if $(IS_INTL_DUMMY), -Dc_link_args='-lintl') \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# build pixman with the Meson build system
define pixman_BUILD
    # Disable tests and demos
    $(SED) -i "/subdir('test')/{N;d;}" '$(SOURCE_DIR)/meson.build'

    '$(TARGET)-meson' \
        -Dopenmp=disabled \
        -Dgtk=disabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# build fribidi with the Meson build system
define fribidi_BUILD
    '$(TARGET)-meson' \
        -Ddocs=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# exclude jpeg, tiff dependencies
# build with -DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT to avoid a
# horrible hack (we don't target pre-Windows XP, so it should be safe)
define lcms_BUILD
    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib \
        CPPFLAGS="-DCMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT"
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
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
endef

# disable GObject introspection
# build with the Meson build system
# force FontConfig since the Win32 font backend within Cairo is disabled
define pango_BUILD
    # Disable utils, examples, tests and tools
    $(SED) -i "/subdir('utils')/{N;N;N;d;}" '$(SOURCE_DIR)/meson.build'

    '$(TARGET)-meson' \
        -Dintrospection=disabled \
        -Dfontconfig=enabled \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# compile with the Rust toolchain
define librsvg_BUILD
    # Allow building vendored sources with `-Zbuild-std`, see:
    # https://github.com/rust-lang/wg-cargo-std-aware/issues/23#issuecomment-720455524
    $(if $(IS_LLVM), \
        cd '$(SOURCE_DIR)' && \
            MXE_ENABLE_NETWORK=1 \
            $(TARGET)-cargo vendor -s '$(PREFIX)/$(BUILD)/lib/rustlib/src/rust/library/test/Cargo.toml')

    $(if $(IS_ARM), \
        (cd '$(SOURCE_DIR)' && $(PATCH) -p1 -u) < $(realpath $(dir $(lastword $(librsvg_PATCHES))))/librsvg-arm.patch)

    # armv7 -> thumbv7a
    $(eval ARCH_NAME := $(if $(findstring armv7,$(PROCESSOR)),thumbv7a,$(PROCESSOR)))

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-introspection \
        RUST_TARGET='$(ARCH_NAME)-pc-windows-gnu' \
        CARGO='$(TARGET)-cargo' \
        RUSTC='$(TARGET)-rustc'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_SCRIPTS=
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
        $(if $(BUILD_STATIC), CPPFLAGS='-DCAIRO_WIN32_STATIC_BUILD') \
        ax_cv_c_float_words_bigendian=no

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB) $(MXE_DISABLE_PROGRAMS)
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
    # Enable networking to allow libpcre to be downloaded from WrapDB
    MXE_ENABLE_NETWORK=1 '$(TARGET)-meson' \
        --default-library=shared \
        --force-fallback-for=libpcre \
        -Dforce_posix_threads=false \
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
