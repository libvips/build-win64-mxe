$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

## Update dependencies

# don't build from git ... it does some introspection to build the test
# suite build files, which won't work in cross-compiler mode
# upstream version is 2.32.3
gdk-pixbuf_VERSION  := 2.36.12
gdk-pixbuf_CHECKSUM := fff85cf48223ab60e3c3c8318e2087131b590fd6f1737e42cb3759a3b427a334
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# no longer needed by libvips, but some of the deps need it
# upstream version is 2.9.4
libxml2_VERSION  := 2.9.8
libxml2_CHECKSUM := 0b74e51595654f958148759cfef0993114ddccccbb6f31aee018f3558e8e2732
libxml2_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libxml2-[0-9]*.patch)))
libxml2_SUBDIR   := libxml2-$(libxml2_VERSION)
libxml2_FILE     := libxml2-$(libxml2_VERSION).tar.gz
libxml2_URL      := http://xmlsoft.org/sources/$(libxml2_FILE)
libxml2_URL_2    := ftp://xmlsoft.org/libxml2/$(libxml2_FILE)

# upstream version is 3.3.6-pl1
fftw_VERSION  := 3.3.8
fftw_CHECKSUM := 6113262f6e92c5bd474f2875fa1b01054c4ad5040f6b0da7c03c98821d9ae303
fftw_SUBDIR   := fftw-$(fftw_VERSION)
fftw_FILE     := fftw-$(fftw_VERSION).tar.gz
fftw_URL      := http://www.fftw.org/$(fftw_FILE)

# 1.5.6 works
# 1.5.8 and 1.5.11 fail to build in a cross-compiler
# upstream version is 1.5.2
matio_VERSION  := 1.5.12
matio_CHECKSUM := 8695e380e465056afa5b5e20128935afe7d50e03830f9f7778a72e1e1894d8a9
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 6.9.0-0
imagemagick_VERSION  := 6.9.10-4
imagemagick_CHECKSUM := 281caddca858604e026036cdc62fbb5d5fc5a1e1190dfd8c704fb09ed1f1e24a
imagemagick_SUBDIR   := ImageMagick-$(imagemagick_VERSION)
imagemagick_FILE     := ImageMagick-$(imagemagick_VERSION).tar.xz
imagemagick_URL      := https://www.imagemagick.org/download/releases/$(imagemagick_FILE)
imagemagick_URL_2    := https://ftp.nluug.nl/ImageMagick/$(imagemagick_FILE)

# librsvg v2.40.20 has a small memory leak, v2.42.0+ requires 
# Rust toolchain
# Note: static linking is broken on 2.42, if static linking is needed; stick with 2.40.20.
# See: https://gitlab.gnome.org/GNOME/librsvg/issues/159
# upstream version is 2.40.5
librsvg_VERSION  := 2.43.1
librsvg_CHECKSUM := 1d631f21c9150bf408819ed94d29829b509392bc2884f9be3c02ec2ed2d77d87
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.42.1
pango_CHECKSUM := 915a6756b298578ff27c7a6393f8c2e62e6e382f9411f2504d7af1a13c7bce32
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 0.19.6
fribidi_VERSION  := 0.19.7
fribidi_CHECKSUM := 08222a6212bbc2276a2d55c3bf370109ae4a35b689acbc66571ad2a670595a8e
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.bz2
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/$(fribidi_VERSION)/$(fribidi_FILE)

# upstream version is 0.6.2
libcroco_VERSION  := 0.6.12
libcroco_CHECKSUM := ddc4b5546c9fb4280a5017e2707fbd4839034ed1aba5b7d4372212f34f84f860
libcroco_SUBDIR   := libcroco-$(libcroco_VERSION)
libcroco_FILE     := libcroco-$(libcroco_VERSION).tar.xz
libcroco_URL      := https://download.gnome.org/sources/libcroco/$(call SHORT_PKG_VERSION,libcroco)/$(libcroco_FILE)

# upstream version is 0.4.4
libwebp_VERSION  := 1.0.0
libwebp_CHECKSUM := 84259c4388f18637af3c5a6361536d754a5394492f91be1abc2e981d4983225b
libwebp_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libwebp-[0-9]*.patch)))
libwebp_SUBDIR   := libwebp-$(libwebp_VERSION)
libwebp_FILE     := libwebp-$(libwebp_VERSION).tar.gz
libwebp_URL      := http://downloads.webmproject.org/releases/webp/$(libwebp_FILE)

# upstream version is 0.51.0
poppler_VERSION  := 0.66.0
poppler_CHECKSUM := 2c096431adfb74bc2f53be466889b7646e1b599f28fa036094f3f7235cc9eae7
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/poppler-[0-9]*.patch)))
poppler_SUBDIR   := poppler-$(poppler_VERSION)
poppler_FILE     := poppler-$(poppler_VERSION).tar.xz
poppler_URL      := https://poppler.freedesktop.org/$(poppler_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.54.2
glib_CHECKSUM := bb89e5c5aad33169a8c7f28b45671c7899c12f74caf707737f784d7102758e6c
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
# TODO: version 1.14.43 is broken. (`conflicting types for 'gsf_input_set_modtime_from_stat'`)
libgsf_VERSION  := 1.14.42
libgsf_CHECKSUM := 29fffb87b278b3fb1b8ae9138c3b4529c1fce664f1f94297c146a8563df80dc2
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# upstream version is 1.15.4
cairo_VERSION  := 1.15.12
cairo_CHECKSUM := 7623081b94548a47ee6839a7312af34e9322997806948b6eec421a8c6d0594c9
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := https://cairographics.org/snapshots/$(cairo_FILE)

# zlib will make libzlib.dll, but we want libz.dll so we must 
# patch CMakeLists.txt
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/zlib-[0-9]*.patch)))

# fix typedef conflicts
libjpeg-turbo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libjpeg-turbo-[0-9]*.patch)))

## Override sub-dependencies

harfbuzz_DEPS           := $(filter-out icu4c,$(harfbuzz_DEPS))
libgsf_DEPS             := $(filter-out bzip2 ,$(libgsf_DEPS))
freetype_DEPS           := $(filter-out bzip2 ,$(freetype_DEPS))
freetype-bootstrap_DEPS := $(filter-out bzip2 ,$(freetype-bootstrap_DEPS))
glib_DEPS               := cc gettext libffi zlib
gdk-pixbuf_DEPS         := cc glib libjpeg-turbo tiff libpng
lcms_DEPS               := cc zlib
tiff_DEPS               := cc libjpeg-turbo xz zlib
imagemagick_DEPS        := cc lcms fftw tiff libjpeg-turbo freetype
pango_DEPS              := cc cairo fontconfig freetype glib harfbuzz fribidi
poppler_DEPS            := cc cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
libwebp_DEPS            := cc gettext giflib libjpeg-turbo tiff libpng
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman
librsvg_DEPS            := cc cairo gdk-pixbuf glib libcroco libgsf pango

## Override build scripts

# icu will pull in standard linux headers, which we don't want
define harfbuzz_BUILD
    # mman-win32 is only a partial implementation
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-icu=no \
        ac_cv_header_sys_mman_h=no \
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
define gdk-pixbuf_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-modules \
        --with-included-loaders \
        --without-gdiplus \
        CPPFLAGS="`'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        GLIB_GENMARSHAL='$(PREFIX)/$(TARGET)/bin/glib-genmarshal' \
        LIBS="`'$(TARGET)-pkg-config' --libs libtiff-4 jpeg-turbo`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
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
        --without-threads \
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
        --with-freetype='$(PREFIX)/$(TARGET)/bin/freetype-config' \
        CPPFLAGS="`'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        LIBS="`'$(TARGET)-pkg-config' --libs jpeg-turbo`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install bin_PROGRAMS=
endef

# without-turbojpeg turns off a library we don't use (we just use the 
# libjpeg API)
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --libdir='$(PREFIX)/$(TARGET)/lib/$(PKG)' \
        --includedir='$(PREFIX)/$(TARGET)/include/$(PKG)' \
        --without-turbojpeg \
        NASM=$(TARGET)-yasm
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)

    # create pkg-config file
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/pkgconfig'
    (echo 'Name: jpeg-turbo'; \
     echo 'Version: $($(PKG)_VERSION)'; \
     echo 'Description: jpeg-turbo'; \
     echo 'Cflags: -I$(PREFIX)/$(TARGET)/include/$(PKG)'; \
     echo 'Libs: -L$(PREFIX)/$(TARGET)/lib/$(PKG) -ljpeg';) \
     > '$(PREFIX)/$(TARGET)/lib/pkgconfig/jpeg-turbo.pc'

    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi -pedantic \
        '$(TOP_DIR)/src/jpeg-test.c' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `'$(TARGET)-pkg-config' jpeg-turbo --cflags --libs`
endef

# disable GObject introspection
define pango_BUILD
    rm '$(SOURCE_DIR)'/docs/Makefile.am
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-explicit-deps \
        --with-included-modules \
        --without-dynamic-modules \
        --disable-introspection \
        CXX='$(TARGET)-g++'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install $(MXE_DISABLE_PROGRAMS)
endef

# compile with the Rust toolchain 
define librsvg_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && RUSTUP_HOME='/usr/local/rustup' \
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

    # Pass static Rust package to linker
    $(SED) -i 's,^deplibs_check_method=.*,deplibs_check_method="pass_all",g' $(BUILD_DIR)/libtool

    # Fix RUST_LIB linking
    $(SED) -i 's,\($$(.*_la_OBJECTS)\) \($$(.*_la_DEPENDENCIES)\),\1 $$\(RUST_LIB\) \2,g' $(SOURCE_DIR)/Makefile.in
    $(SED) -i 's,\($$(.*_la_OBJECTS)\) \($$(.*_la_LIBADD)\),\1 $$\(RUST_LIB\) \2,g' $(SOURCE_DIR)/Makefile.in

    $(MAKE) \
        -C '$(BUILD_DIR)' \
        -j '$(JOBS)' \
        RUSTUP_HOME='/usr/local/rustup' \
        CARGO_HOME='/usr/local/cargo' \
        PATH='/usr/local/cargo/bin:$(PATH)'

    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    '$(TARGET)-gcc' \
        -mwindows -W -Wall -Werror -Wno-deprecated-declarations \
        -std=c99 -pedantic \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-librsvg.exe' \
        `'$(TARGET)-pkg-config' librsvg-2.0 --cflags --libs`
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
        -DCMAKE_INCLUDE_PATH='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        -DCMAKE_LIBRARY_PATH='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# the zlib configure is a bit basic, so use cmake
define zlib_BUILD
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

define zlib_BUILD_SHARED
     $($(PKG)_BUILD)
endef

# disable the C++ API for now, we don't use it anyway
# build with libjpeg-turbo and without lzma
define tiff_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --without-x \
        --disable-cxx \
        --disable-lzma \
        --with-jpeg-include-dir='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-lib-dir='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

# build with libjpeg-turbo
define libwebp_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-libwebpmux \
        --enable-libwebpdemux \
        CPPFLAGS="`'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        LIBS="`'$(TARGET)-pkg-config' --libs jpeg-turbo`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_PROGRAMS)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_PROGRAMS)
endef

# replace libpng12 with libpng16
define cairo_BUILD
    $(SED) -i 's,libpng12,libpng16,g'                        '$(SOURCE_DIR)/configure'
    $(SED) -i 's,^\(Libs:.*\),\1 @CAIRO_NONPKGCONFIG_LIBS@,' '$(SOURCE_DIR)/src/cairo.pc.in'
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
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
        --disable-script
        --enable-win32 \
        --enable-win32-font \
        --enable-png \
        --enable-ft \
        --enable-pdf \
        --enable-svg \
        --disable-pthread \
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
    $(MAKE) -C '$(1)' -j '$(JOBS)' bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(1)' -j 1 install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    ln -sf '$(PREFIX)/$(TARGET)/bin/xml2-config' '$(PREFIX)/bin/$(TARGET)-xml2-config'
endef

# compile with the internal PCRE library
define glib_BUILD
    # other packages expect glib-tools in $(TARGET)/bin
    rm -f  '$(PREFIX)/$(TARGET)/bin/glib-*'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-genmarshal'        '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-schemas'   '$(PREFIX)/$(TARGET)/bin/'
    ln -sf '$(PREFIX)/$(BUILD)/bin/glib-compile-resources' '$(PREFIX)/$(TARGET)/bin/'

    # cross build
    cd '$(SOURCE_DIR)' && NOCONFIGURE=true ./autogen.sh
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --with-threads=win32 \
        --with-pcre=internal \
        --with-libiconv=gnu \
        --disable-inotify \
        CXX='$(TARGET)-g++' \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config' \
        GLIB_GENMARSHAL='$(PREFIX)/$(TARGET)/bin/glib-genmarshal' \
        GLIB_COMPILE_SCHEMAS='$(PREFIX)/$(TARGET)/bin/glib-compile-schemas' \
        GLIB_COMPILE_RESOURCES='$(PREFIX)/$(TARGET)/bin/glib-compile-resources'
    $(MAKE) -C '$(BUILD_DIR)/glib'    -j '$(JOBS)' install sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)/gmodule' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)/gthread' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)/gobject' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)/gio'     -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= MISC_STUFF=
    $(MAKE) -C '$(BUILD_DIR)'         -j '$(JOBS)' install-pkgconfigDATA
    $(MAKE) -C '$(BUILD_DIR)/m4macros' install
endef
