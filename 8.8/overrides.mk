$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

# Install the mingw-w64 headers somewhere else
# because we need to distribute the /include and
# /lib directories
mingw-w64-headers_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw'

# Common configure options for building mingw-w64-crt
# and winpthreads somewhere else
common_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw' \
--with-sysroot='$(PREFIX)/$(TARGET)/mingw' \
CPPFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include' \
CFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include -s -O3 -ffast-math' \
CXXFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include -s -O3 -ffast-math' \
LDFLAGS='-L$(PREFIX)/$(TARGET)/mingw/lib' \
RCFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include'

# Override GCC patches with our own patches
gcc_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gcc-[0-9]*.patch)))

# Point native system header dir to /mingw/include and
# compile without some optimizations / stripping
gcc_CONFIGURE_OPTS=--with-native-system-header-dir='/mingw/include' \
CFLAGS='-s -O3 -ffast-math' \
CXXFLAGS='-s -O3 -ffast-math' \
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
gdk-pixbuf_VERSION  := 2.38.1
gdk-pixbuf_CHECKSUM := f19ff836ba991031610dcc53774e8ca436160f7d981867c8c3a37acfe493ab3a
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# upstream version is 1.5.2
matio_VERSION  := 1.5.15
matio_CHECKSUM := 21bf4587bb7f0231dbb4fcc88728468f1764c06211d5a0415cd622036f09b1cf
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 6.9.0-0
imagemagick_VERSION  := 6.9.10-48
imagemagick_CHECKSUM := a010b894d4685f8a0a51e0b3c8097a16654b12509b4aee448e25a3edb5ac616d
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_SUBDIR   := ImageMagick6-$(imagemagick_VERSION)
imagemagick_FILE     := $(imagemagick_VERSION).tar.gz
imagemagick_URL      := https://github.com/ImageMagick/ImageMagick6/archive/$(imagemagick_FILE)

# upstream version is 2.4
x265_VERSION  := 3.0
x265_CHECKSUM := c5b9fc260cabbc4a81561a448f4ce9cad7218272b4011feabc3a6b751b2f0662
x265_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/x265-[0-9]*.patch)))
x265_SUBDIR   := x265_$(x265_VERSION)
x265_FILE     := x265_$(x265_VERSION).tar.gz
x265_URL      := https://bitbucket.org/multicoreware/x265/downloads/$(x265_FILE)
x265_URL_2    := ftp://ftp.videolan.org/pub/videolan/x265/$(x265_FILE)

# upstream version is 2.40.5
librsvg_VERSION  := 2.45.6
librsvg_CHECKSUM := 0e6e26cb5c79cfa73c0ddab06808ace4d10c4a626b81c31a75ead37c6cb4df41
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.43.0
pango_CHECKSUM := d2c0c253a5328a0eccb00cdd66ce2c8713fabd2c9836000b6e22a8b06ba3ddd2
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# Use the mutex helper from mingw-std-threads
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))

# upstream version is 0.6.2
libcroco_VERSION  := 0.6.13
libcroco_CHECKSUM := 767ec234ae7aa684695b3a735548224888132e063f92db585759b422570621d4
libcroco_SUBDIR   := libcroco-$(libcroco_VERSION)
libcroco_FILE     := libcroco-$(libcroco_VERSION).tar.xz
libcroco_URL      := https://download.gnome.org/sources/libcroco/$(call SHORT_PKG_VERSION,libcroco)/$(libcroco_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.61.1
glib_CHECKSUM := f8d827955f0d8e197ff5c2105dd6ac4f6b63d15cd021eb1de66534c92a762161
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
libgsf_VERSION  := 1.14.46
libgsf_CHECKSUM := ea36959b1421fc8e72caa222f30ec3234d0ed95990e2bf28943a85f33eadad2d
libgsf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libgsf-[0-9]*.patch)))
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# zlib will make libzlib.dll, but we want libz.dll so we must 
# patch CMakeLists.txt
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

# upstream version is 2.2.0
openexr_VERSION  := 2.3.0
openexr_CHECKSUM := 8243b7de12b52239fe9235a6aeb4e35ead2247833e4fbc41541774b222717933
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
# See: https://github.com/openexr/openexr/issues/333
openexr_URL      := https://github.com/openexr/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 2.2.0
ilmbase_VERSION  := 2.3.0
ilmbase_CHECKSUM := 456978d1a978a5f823c7c675f3f36b0ae14dba36638aeaa3c4b0e784f12a3862
ilmbase_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/ilmbase-[0-9]*.patch)))
ilmbase_SUBDIR   := ilmbase-$(ilmbase_VERSION)
ilmbase_FILE     := ilmbase-$(ilmbase_VERSION).tar.gz
ilmbase_URL      := https://github.com/openexr/openexr/releases/download/v$(ilmbase_VERSION)/$(ilmbase_FILE)

# upstream version is 3410
cfitsio_VERSION  := 3450
cfitsio_CHECKSUM := bf6012dbe668ecb22c399c4b7b2814557ee282c74a7d5dc704eb17c30d9fb92e
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio
cfitsio_FILE     := cfitsio$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)
cfitsio_URL_2    := https://mirrorservice.org/sites/distfiles.macports.org/cfitsio/$(cfitsio_FILE)

# upstream version is 2.4.0
harfbuzz_VERSION  := 2.5.1
harfbuzz_CHECKSUM := 6d4834579abd5f7ab3861c085b4c55129f78b27fe47961fd96769d3704f6719e
harfbuzz_SUBDIR   := harfbuzz-$(harfbuzz_VERSION)
harfbuzz_FILE     := harfbuzz-$(harfbuzz_VERSION).tar.xz
harfbuzz_URL      := https://www.freedesktop.org/software/harfbuzz/release/$(harfbuzz_FILE)

# upstream version is 0.33.6
# Note: Can't build statically with the Meson build system,
# it will always output a shared library.
pixman_VERSION  := 0.38.4
pixman_CHECKSUM := da66d6fd6e40aee70f7bd02e4f8f76fc3f006ec879d346bae6a723025cfbdde7
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# Override libjpeg-turbo patch with our own
libjpeg-turbo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libjpeg-turbo-[0-9]*.patch)))

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
#  Removed: libwebp
#  Replaced: jpeg with libjpeg-turbo
# ImageMagick:
#  Removed: bzip2, ffmpeg, freetype, jasper, liblqr-1, libltdl, libpng, openexr, tiff
#  Replaced: jpeg with libjpeg-turbo
# Pango:
#  Added: fribidi
# Poppler:
#  Removed: curl, qtbase, libwebp
#  Added: mingw-std-threads, libjpeg-turbo, lcms
# libwebp:
#  Added: gettext, giflib, libjpeg-turbo, tiff, libpng
# Cairo:
#  Removed: lzo zlib
# x265:
#  Replaced: yasm with $(BUILD)~nasm

harfbuzz_DEPS           := $(filter-out icu4c,$(harfbuzz_DEPS))
libgsf_DEPS             := $(filter-out bzip2 ,$(libgsf_DEPS))
freetype_DEPS           := $(filter-out bzip2 ,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(filter-out bzip2 ,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc gettext libffi zlib
gdk-pixbuf_DEPS         := cc glib libjpeg-turbo libpng tiff
lcms_DEPS               := $(filter-out jpeg tiff ,$(lcms_DEPS))
tiff_DEPS               := cc libjpeg-turbo xz zlib
imagemagick_DEPS        := cc lcms fftw tiff libjpeg-turbo freetype pthreads
pango_DEPS              := $(pango_DEPS) fribidi
poppler_DEPS            := cc mingw-std-threads cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
libwebp_DEPS            := $(libwebp_DEPS) gettext giflib libjpeg-turbo tiff libpng
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman
x265_DEPS               := cc $(BUILD)~nasm

## Override build scripts

# icu will pull in standard linux headers, which we don't want,
# build with CMake.
define harfbuzz_BUILD
    # mman-win32 is only a partial implementation
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DHB_HAVE_GLIB=ON \
        -DHB_HAVE_FREETYPE=ON \
        -DHB_HAVE_ICU=OFF \
        -DHAVE_SYS_MMAN_H=OFF \
        -DHB_BUILD_UTILS=OFF \
        -DHB_BUILD_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    # create pkg-config file, see:
    # https://github.com/harfbuzz/harfbuzz/issues/896
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'prefix=$(PREFIX)/$(TARGET)'; \
     echo 'exec_prefix=$${prefix}'; \
     echo 'libdir=$${exec_prefix}/lib'; \
     echo 'includedir=$${prefix}/include'; \
     echo ''; \
     echo 'Name: $(PKG)'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: HarfBuzz text shaping library'; \
     echo 'Libs: -L$${libdir} -lharfbuzz'; \
     echo 'Cflags: -I$${includedir}/harfbuzz';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/$(PKG).pc'
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
        --without-heic \
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
    cd '$(SOURCE_DIR)' && autoreconf -fi
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-gtk-doc \
        --disable-introspection \
        --disable-tools \
        LIBS='-lws2_32 -luserenv' \
        RUST_TARGET=$(firstword $(subst -, ,$(TARGET)))-pc-windows-gnu \
        AR='$(TARGET)-ar'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)
endef

# compile with CMake and with libjpeg-turbo
define poppler_BUILD
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
        -DCMAKE_CXX_FLAGS="-I$(PREFIX)/$(TARGET)/include/mingw-std-threads" \
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
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dforce_posix_threads=false \
        -Dinternal_pcre=true \
        -Diconv='external' \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
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

# `-DENABLE_DYNAMIC_HDR10=ON` -> `-DENABLE_HDR10_PLUS=ON`
# x265 requires nasm 2.13 or newer (instead than yasm) after release 2.6.
define x265_BUILD
    cd '$(BUILD_DIR)' && mkdir -p 10bit 12bit

    # 12 bit
    cd '$(BUILD_DIR)/12bit' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DHIGH_BIT_DEPTH=ON \
        -DEXPORT_C_API=OFF \
        -DENABLE_SHARED=OFF \
        -DENABLE_ASSEMBLY=$(if $(findstring x86_64,$(TARGET)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DWINXP_SUPPORT=ON \
        -DENABLE_HDR10_PLUS=ON \
        -DMAIN12=ON
    $(MAKE) -C '$(BUILD_DIR)/12bit' -j '$(JOBS)'
    cp '$(BUILD_DIR)/12bit/libx265.a' '$(BUILD_DIR)/libx265_main12.a'

    # 10 bit
    cd '$(BUILD_DIR)/10bit' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DHIGH_BIT_DEPTH=ON \
        -DEXPORT_C_API=OFF \
        -DENABLE_SHARED=OFF \
        -DENABLE_ASSEMBLY=$(if $(findstring x86_64,$(TARGET)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DWINXP_SUPPORT=ON \
        -DENABLE_HDR10_PLUS=ON
    $(MAKE) -C '$(BUILD_DIR)/10bit' -j '$(JOBS)'
    cp '$(BUILD_DIR)/10bit/libx265.a' '$(BUILD_DIR)/libx265_main10.a'

    # 8bit
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DHIGH_BIT_DEPTH=OFF \
        -DEXPORT_C_API=ON \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_ASSEMBLY=$(if $(findstring x86_64,$(TARGET)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DWINXP_SUPPORT=ON \
        -DENABLE_HDR10_PLUS=ON \
        -DEXTRA_LIB='x265_main10.a;x265_main12.a' \
        -DEXTRA_LINK_FLAGS=-L'$(BUILD_DIR)' \
        -DLINKED_10BIT=ON \
        -DLINKED_12BIT=ON

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install
    $(if $(BUILD_SHARED),rm -f '$(PREFIX)/$(TARGET)/lib/libx265.a',\
        $(INSTALL) '$(BUILD_DIR)/libx265_main12.a' '$(PREFIX)/$(TARGET)/lib/libx265_main12.a' && \
        $(INSTALL) '$(BUILD_DIR)/libx265_main10.a' '$(PREFIX)/$(TARGET)/lib/libx265_main10.a' && \
        $(SED) -i 's|-lx265|-lx265 -lx265_main10 -lx265_main12|' '$(PREFIX)/$(TARGET)/lib/pkgconfig/x265.pc')

    '$(TARGET)-gcc' \
        -W -Wall -Werror \
        '$(TOP_DIR)/src/$(PKG)-test.c' \
        -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `$(TARGET)-pkg-config --cflags --libs $(PKG)`
endef
