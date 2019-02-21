$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

# Install the mingw-w64 headers somewhere else
# because we need to distribute the /include and
# /lib directories
mingw-w64-headers_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw'

# Common configure options for building mingw-w64-crt
# and winpthreads somewhere else
common_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw' \
--with-sysroot='$(PREFIX)/$(TARGET)/mingw' \
CPPFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include -D_FORTIFY_SOURCE=2' \
CFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include -s -Os -ffast-math -ftree-vectorize -static-libgcc' \
CXXFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include -s -Os -ffast-math -ftree-vectorize -static-libgcc -static-libstdc++' \
LDFLAGS='-L$(PREFIX)/$(TARGET)/mingw/lib' \
RCFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include'

# Point native system header dir to /mingw/include and
# compile without some optimizations / stripping
gcc_CONFIGURE_OPTS=--with-native-system-header-dir='/mingw/include' \
CPPFLAGS='-D_FORTIFY_SOURCE=2' \
CFLAGS='-s -Os -ffast-math -ftree-vectorize -static-libgcc' \
CXXFLAGS='-s -Os -ffast-math -ftree-vectorize -static-libgcc -static-libstdc++' \
LDFLAGS=''

# The trick here is to symlink all files from /mingw/{bin,lib,include}/
# to $(PREFIX)/$(TARGET) just before the make command
# This ensures that all files are found during linking and that we
# can clean up those unnecessary files afterwards
define gcc_BUILD_x86_64-w64-mingw32
    $(subst # build rest of gcc, ln -sf $(PREFIX)/$(TARGET)/mingw/bin/* $(PREFIX)/$(TARGET)/bin && \
    ln -sf $(PREFIX)/$(TARGET)/mingw/lib/* $(PREFIX)/$(TARGET)/lib && \
    ln -sf $(PREFIX)/$(TARGET)/mingw/include/* $(PREFIX)/$(TARGET)/include, \
    $(subst @gcc-crt-config-opts@,--disable-lib32 $(common_CONFIGURE_OPTS), \
    $(subst winpthreads/configure' $(MXE_CONFIGURE_OPTS),winpthreads/configure' $(MXE_CONFIGURE_OPTS) $(common_CONFIGURE_OPTS), \
    $(gcc_BUILD_mingw-w64))))
endef

define gcc_BUILD_i686-w64-mingw32
    $(subst # build rest of gcc, ln -sf $(PREFIX)/$(TARGET)/mingw/bin/* $(PREFIX)/$(TARGET)/bin && \
    ln -sf $(PREFIX)/$(TARGET)/mingw/lib/* $(PREFIX)/$(TARGET)/lib && \
    ln -sf $(PREFIX)/$(TARGET)/mingw/include/* $(PREFIX)/$(TARGET)/include, \
    $(subst @gcc-crt-config-opts@,--disable-lib64 $(common_CONFIGURE_OPTS), \
    $(subst winpthreads/configure' $(MXE_CONFIGURE_OPTS),winpthreads/configure' $(MXE_CONFIGURE_OPTS) $(common_CONFIGURE_OPTS), \
    $(gcc_BUILD_mingw-w64))))
endef

## Update dependencies

# upstream version is 2.32.3
gdk-pixbuf_VERSION  := 2.38.0
gdk-pixbuf_CHECKSUM := dd50973c7757bcde15de6bcd3a6d462a445efd552604ae6435a0532fbbadae47
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.9.4
libxml2_VERSION  := 2.9.9
libxml2_CHECKSUM := 94fb70890143e3c6549f265cee93ec064c80a84c42ad0f23e85ee1fd6540a871
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.gz
libxml2_URL      := http://xmlsoft.org/sources/$(libxml2_FILE)
libxml2_URL_2    := ftp://xmlsoft.org/libxml2/$(libxml2_FILE)

# upstream version is 1.5.2
matio_VERSION  := 1.5.13
matio_CHECKSUM := feadb2f54ba7c9db6deba8c994e401d7a1a8e7afd0fe74487691052b8139e5cb
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 6.9.0-0
imagemagick_VERSION  := 6.9.10-28
imagemagick_CHECKSUM := 4b2a2666c6a0acc6f2c469e7df82a090e4d10e39b7035ed911dbd65d0c4d688c
imagemagick_SUBDIR   := ImageMagick-$(imagemagick_VERSION)
imagemagick_FILE     := ImageMagick-$(imagemagick_VERSION).tar.xz
imagemagick_URL      := https://www.imagemagick.org/download/releases/$(imagemagick_FILE)
imagemagick_URL_2    := https://ftp.nluug.nl/ImageMagick/$(imagemagick_FILE)

# upstream version is 2.40.5
librsvg_VERSION  := 2.45.5
librsvg_CHECKSUM := 600872dc608fe5e01bfd8d5b3046d01b53b99121bc5ab9663531b53630843700
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.43.0
pango_CHECKSUM := d2c0c253a5328a0eccb00cdd66ce2c8713fabd2c9836000b6e22a8b06ba3ddd2
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 0.6.2
libcroco_VERSION  := 0.6.12
libcroco_CHECKSUM := ddc4b5546c9fb4280a5017e2707fbd4839034ed1aba5b7d4372212f34f84f860
libcroco_SUBDIR   := libcroco-$(libcroco_VERSION)
libcroco_FILE     := libcroco-$(libcroco_VERSION).tar.xz
libcroco_URL      := https://download.gnome.org/sources/libcroco/$(call SHORT_PKG_VERSION,libcroco)/$(libcroco_FILE)

# upstream version is 0.51.0
poppler_VERSION  := 0.74.0
poppler_CHECKSUM := 92e09fd3302567fd36146b36bb707db43ce436e8841219025a82ea9fb0076b2f
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/poppler-[0-9]*.patch)))
poppler_SUBDIR   := poppler-$(poppler_VERSION)
poppler_FILE     := poppler-$(poppler_VERSION).tar.xz
poppler_URL      := https://poppler.freedesktop.org/$(poppler_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.59.3
glib_CHECKSUM := dfefafbc37bbcfb8101f3f181f880e8b7a8bee48620c92869ec4ef1d3d648e5e
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
libgsf_VERSION  := 1.14.45
libgsf_CHECKSUM := 5cbc2c0f1dc44d202fa0c6e3a51e9f17b0c2deb8711ba650432bfde3180b69fa
libgsf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libgsf-[0-9]*.patch)))
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# zlib will make libzlib.dll, but we want libz.dll so we must 
# patch CMakeLists.txt
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/zlib-[0-9]*.patch)))

# upstream version is 2.2.0
openexr_VERSION  := 2.3.0
openexr_CHECKSUM := 8243b7de12b52239fe9235a6aeb4e35ead2247833e4fbc41541774b222717933
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
# See: https://github.com/openexr/openexr/issues/333
openexr_URL      := https://github.com/openexr/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 2.2.0
ilmbase_VERSION  := 2.3.0
ilmbase_CHECKSUM := 456978d1a978a5f823c7c675f3f36b0ae14dba36638aeaa3c4b0e784f12a3862
ilmbase_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/ilmbase-[0-9]*.patch)))
ilmbase_SUBDIR   := ilmbase-$(ilmbase_VERSION)
ilmbase_FILE     := ilmbase-$(ilmbase_VERSION).tar.gz
ilmbase_URL      := https://github.com/openexr/openexr/releases/download/v$(ilmbase_VERSION)/$(ilmbase_FILE)

# upstream version is 3410
cfitsio_VERSION  := 3450
cfitsio_CHECKSUM := bf6012dbe668ecb22c399c4b7b2814557ee282c74a7d5dc704eb17c30d9fb92e
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio
cfitsio_FILE     := cfitsio$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)

# upstream version is 0.33.6
# Note: Can't build statically with the Meson build system,
# it will always output a shared library.
pixman_VERSION  := 0.38.0
pixman_CHECKSUM := a7592bef0156d7c27545487a52245669b00cf7e70054505381cff2136d890ca8
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# upstream version is 2.2.0
harfbuzz_VERSION  := 2.3.1
harfbuzz_CHECKSUM := f205699d5b91374008d6f8e36c59e419ae2d9a7bb8c5d9f34041b9a5abcae468
harfbuzz_SUBDIR   := harfbuzz-$(harfbuzz_VERSION)
harfbuzz_FILE     := harfbuzz-$(harfbuzz_VERSION).tar.bz2
harfbuzz_URL      := https://www.freedesktop.org/software/harfbuzz/release/$(harfbuzz_FILE)

# Override libjpeg-turbo patch with our own
libjpeg-turbo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libjpeg-turbo-[0-9]*.patch)))

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
# TIFF:
#  Replaced: jpeg with libjpeg-turbo
# ImageMagick:
#  Removed: bzip2, ffmpeg, freetype, jasper, liblqr-1, libltdl, libpng, openexr, pthreads, tiff
#  Replaced: jpeg with libjpeg-turbo
# Pango:
#  Added: fribidi
# Poppler:
#  Removed: curl, qtbase
#  Added: libjpeg-turbo, openjpeg, lcms
# libwebp:
#  Added: gettext, giflib, libjpeg-turbo, tiff, libpng
# Cairo:
#  Removed: lzo zlib

harfbuzz_DEPS           := $(filter-out icu4c,$(harfbuzz_DEPS))
libgsf_DEPS             := $(filter-out bzip2 ,$(libgsf_DEPS))
freetype_DEPS           := $(filter-out bzip2 ,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(filter-out bzip2 ,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc gettext libffi zlib
gdk-pixbuf_DEPS         := cc glib libjpeg-turbo libpng tiff
lcms_DEPS               := $(filter-out jpeg tiff ,$(lcms_DEPS))
tiff_DEPS               := $(subst jpeg,libjpeg-turbo,$(tiff_DEPS))
imagemagick_DEPS        := cc lcms fftw tiff libjpeg-turbo freetype
pango_DEPS              := $(pango_DEPS) fribidi
poppler_DEPS            := cc cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
libwebp_DEPS            := $(libwebp_DEPS) gettext giflib libjpeg-turbo tiff libpng
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman

## Override build scripts

# icu will pull in standard linux headers, which we don't want
define harfbuzz_BUILD
    # mman-win32 is only a partial implementation
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-icu=no \
        ac_cv_header_sys_mman_h=no \
        CXXFLAGS='$(CXXFLAGS) -std=c++11' \
        LIBS='-lstdc++'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# exclude bz2 and gdk-pixbuf
define libgsf_BUILD
    $(SED) -i 's,\ssed\s, $(SED) ,g'           '$(SOURCE_DIR)'/gsf/Makefile.in
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-nls \
        --without-gdk-pixbuf \
        --disable-gtk-doc \
        --without-python \
        --without-bz2 \
        --with-zlib \
        --with-gio \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config'
    $(MAKE) -C '$(BUILD_DIR)'     -j '$(JOBS)' install-pkgconfigDATA $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)/gsf' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# build gdk-pixbuf with libjpeg-turbo
# and the Meson build system
define gdk-pixbuf_BUILD
    '$(TARGET)-meson' \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dbuiltin_loaders='jpeg,png,tiff' \
        -Dgir=false \
        -Dx11=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# exclude jpeg, tiff dependencies
define lcms_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# disable largefile support, we rely on vips for that and ImageMagick's
# detection does not work when cross-compiling
# build with jpeg-turbo and without lzma 
define imagemagick_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-x \
        --without-lzma \
        --without-modules \
        --without-openexr \
        --without-gvc \
        --without-lqr \
        --without-magick-plus-plus \
        --disable-largefile \
        --without-rsvg \
        --disable-openmp \
        --without-zlib \
        --with-freetype='$(PREFIX)/$(TARGET)/bin/freetype-config'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the 
# libjpeg API)
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DWITH_TURBOJPEG=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER=$(TARGET)-yasm
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# disable GObject introspection
# build with the Meson build system
define pango_BUILD
    '$(TARGET)-meson' \
        --libdir='lib' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dgir=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# compile with the Rust toolchain 
define librsvg_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && RUSTUP_HOME='/usr/local/rustup' \
    RUSTFLAGS='-C panic=abort' \
    CARGO_HOME='/usr/local/cargo' \
    PATH='/usr/local/cargo/bin:$(PATH)' \
    $(SOURCE_DIR)/configure \
        $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-gtk-doc \
        --disable-introspection \
        --disable-tools \
        LIBS="-lws2_32 -luserenv" \
        RUST_TARGET=$(firstword $(subst -, ,$(TARGET)))-pc-windows-gnu

    $(MAKE) \
        -C '$(BUILD_DIR)' \
        -j '$(JOBS)' \
        RUSTUP_HOME='/usr/local/rustup' \
        RUSTFLAGS='-C panic=abort' \
        CARGO_HOME='/usr/local/cargo' \
        PATH='/usr/local/cargo/bin:$(PATH)'

    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)
endef

# compile with CMake and with libjpeg-turbo
define poppler_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DENABLE_ZLIB=ON \
        -DENABLE_LIBTIFF=ON \
        -DENABLE_LIBPNG=ON \
        -DENABLE_GLIB=ON \
        -DENABLE_CMS='lcms2' \
        -DENABLE_LIBOPENJPEG='openjpeg2' \
        -DENABLE_DCTDECODER='libjpeg' \
        -DFONT_CONFIGURATION=win32 \
        -DENABLE_XPDF_HEADERS=OFF \
        -DENABLE_SPLASH=OFF \
        -DENABLE_CPP=OFF \
        -DBUILD_GTK_TESTS=OFF \
        -DENABLE_UTILS=OFF \
        -DENABLE_QT5=OFF \
        -DENABLE_LIBCURL=OFF \
        -DBUILD_QT5_TESTS=OFF \
        -DBUILD_CPP_TESTS=OFF \
        -DENABLE_GTK_DOC=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# the zlib configure is a bit basic, so use cmake for shared
# builds
define zlib_BUILD_SHARED
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'prefix=$(PREFIX)/$(TARGET)'; \
     echo 'exec_prefix=$${prefix}'; \
     echo 'libdir=$${exec_prefix}/lib'; \
     echo 'includedir=$${prefix}/include'; \
     echo ''; \
     echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: $(PKG) compression library'; \
     echo 'Libs: -L$${libdir} -lz'; \
     echo 'Cflags: -I$${includedir}';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/$(PKG).pc'
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

# build with libjpeg-turbo
define libwebp_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-libwebpmux \
        --enable-libwebpdemux
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# replace libpng12 with libpng16
define cairo_BUILD
    $(SED) -i 's,libpng12,libpng16,g'                        '$(SOURCE_DIR)/configure'
    $(SED) -i 's,^\(Libs:.*\),\1 @CAIRO_NONPKGCONFIG_LIBS@,' '$(SOURCE_DIR)/src/cairo.pc.in'
    cd '$(BUILD_DIR)' && ax_cv_c_float_words_bigendian=no \
    $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gl \
        --disable-lto \
        --disable-gtk-doc \
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
        --enable-win32 \
        --enable-win32-font \
        --enable-png \
        --enable-ft \
        --enable-pdf \
        --enable-svg \
        --without-x \
        CFLAGS="$(CFLAGS) $(if $(BUILD_STATIC),-DCAIRO_WIN32_STATIC_BUILD)" \
        LIBS="-lmsimg32 -lgdi32 `$(TARGET)-pkg-config pixman-1 --libs`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install $(MXE_DISABLE_PROGRAMS)
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

# build without lzma
define libxml2_BUILD
    $(SED) -i 's,`uname`,MinGW,g' '$(1)/xml2-config.in'
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-zlib='$(PREFIX)/$(TARGET)/lib' \
        --without-lzma \
        --without-debug \
        --without-python \
        --without-threads
    $(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_CRUFT)
    ln -sf '$(PREFIX)/$(TARGET)/bin/xml2-config' '$(PREFIX)/bin/$(TARGET)-xml2-config'
endef

# build with the Meson build system
# compile with the internal PCRE library and
# posix threads
define glib_BUILD
    # other packages expect glib-tools in $(TARGET)/bin
    rm -f  '$(PREFIX)/$(TARGET)/bin/glib-*'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-genmarshal'        '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-schemas'   '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-resources' '$(PREFIX)/$(TARGET)/bin/'

    # cross build
    '$(TARGET)-meson' \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dforce_posix_threads=true \
        -Dinternal_pcre=true \
        -Diconv='native' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install

    # We need `libgobject-2.0-0.dll` and `libglib-2.0-0.dll` for the language bindings
    $(if $(BUILD_STATIC), \
        $(foreach LIB, glib gobject, \
            $(MAKE_SHARED_FROM_STATIC) --libdir '$(PREFIX)/$(TARGET)/lib' \
            --libprefix 'lib' --libsuffix '-0' --objext '.obj' \
            '$(BUILD_DIR)/$(LIB)/lib$(LIB)-2.0.a' \
            `$(TARGET)-pkg-config --libs-only-l $(LIB)-2.0` -lintl && \
            ln -sf '$(PREFIX)/$(TARGET)/lib/lib$(LIB)-2.0-0.dll.a' \
                   '$(PREFIX)/$(TARGET)/lib/lib$(LIB)-2.0.a';))
endef

# build with CMake.
define openexr_BUILD
    # downgrade minimum required version of CMake (it's unnecessarily high).
    find '$(SOURCE_DIR)' -name 'CMakeLists.txt' \
        -exec $(SED) -i 's,CMAKE_MINIMUM_REQUIRED(VERSION 3.11),CMAKE_MINIMUM_REQUIRED(VERSION 3.10),g' {} \;

    # Use autotools with README.md
    ln -s '$(SOURCE_DIR)/IlmBase/README.md' '$(SOURCE_DIR)/IlmBase/README'

    # Update auto-stuff, except autoheader, because if fails...
    cd '$(SOURCE_DIR)/IlmBase' && AUTOHEADER=true autoreconf -fi

    # build a native version of IlmBase
    cd '$(SOURCE_DIR)/IlmBase' && $(SHELL) ./configure \
        --build="`config.guess`" \
        --disable-shared \
        --prefix='$(SOURCE_DIR)/IlmBase' \
        --enable-threading=yes \
        CONFIG_SHELL=$(SHELL) \
        SHELL=$(SHELL)
    $(MAKE) -C '$(SOURCE_DIR)/IlmBase' -j '$(JOBS)' install $(MXE_DISABLE_PROGRAMS)

    # build OpenEXR with CMake.
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DOPENEXR_BUILD_ILMBASE=OFF \
        -DOPENEXR_BUILD_PYTHON_LIBS=OFF \
        -DOPENEXR_BUILD_TESTS=OFF \
        -DOPENEXR_BUILD_UTILS=OFF \
        -DOPENEXR_BUILD_SHARED=$(if $(BUILD_STATIC),OFF,ON) \
        -DOPENEXR_BUILD_STATIC=$(if $(BUILD_STATIC),ON,OFF) \
        -DILMBASE_PACKAGE_PREFIX='$(PREFIX)/$(TARGET)' \
        -DILMBASE_INCLUDE_DIR='$(PREFIX)/$(TARGET)/include' \
        -DILMBASE_LIBRARIES='$(PREFIX)/$(TARGET)/lib' \
        '$(SOURCE_DIR)'

    # build the code generator manually
    cd '$(SOURCE_DIR)/OpenEXR/IlmImf/' && $(BUILD_CXX) -O2 \
        -I'$(SOURCE_DIR)/IlmBase/include/OpenEXR' \
        -L'$(SOURCE_DIR)/IlmBase/lib' \
        b44ExpLogTable.cpp \
        -lHalf \
        -o b44ExpLogTable
    '$(SOURCE_DIR)/OpenEXR/IlmImf/b44ExpLogTable' > '$(SOURCE_DIR)/OpenEXR/IlmImf/b44ExpLogTable.h'
    cd '$(SOURCE_DIR)/OpenEXR/IlmImf/' && $(BUILD_CXX) -O2 \
        -I'$(SOURCE_DIR)/OpenEXR/config.windows' -I. \
        -I'$(SOURCE_DIR)/IlmBase/include/OpenEXR' \
        -L'$(SOURCE_DIR)/IlmBase/lib' \
        dwaLookups.cpp \
        -lHalf -lIlmThread -lIex -lpthread \
        -o dwaLookups
    '$(SOURCE_DIR)/OpenEXR/IlmImf/dwaLookups' > '$(SOURCE_DIR)/OpenEXR/IlmImf/dwaLookups.h'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# build with CMake.
define ilmbase_BUILD
    # downgrade minimum required version of CMake (it's unnecessarily high).
    find '$(SOURCE_DIR)' -name 'CMakeLists.txt' \
        -exec $(SED) -i 's,CMAKE_MINIMUM_REQUIRED(VERSION 3.11),CMAKE_MINIMUM_REQUIRED(VERSION 3.10),g' {} \;
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DOPENEXR_FORCE_CXX03=ON \
        -DENABLE_TESTS=OFF \
        -DBUILD_ILMBASE_STATIC=ON \
        '$(SOURCE_DIR)'

    # do the first build step by hand, because programs are built that
    # generate source files
    cd '$(SOURCE_DIR)/Half' && $(BUILD_CXX) eLut.cpp -o eLut
    '$(SOURCE_DIR)/Half/eLut' > '$(BUILD_DIR)/Half/eLut.h'
    cd '$(SOURCE_DIR)/Half' && $(BUILD_CXX) toFloat.cpp -o toFloat
    '$(SOURCE_DIR)/Half/toFloat' > '$(BUILD_DIR)/Half/toFloat.h'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define cfitsio_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DBUILD_SHARED_LIBS=ON

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config files
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Libs: -l$(PKG)';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/$(PKG).pc'

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-cfitsio.exe' \
        `'$(TARGET)-pkg-config' cfitsio --cflags --libs`
endef
