$(info == General overrides: $(lastword $(MAKEFILE_LIST)))

# Install the mingw-w64 headers somewhere else
# because we need to distribute the /include and
# /lib directories
mingw-w64-headers_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw'

# Some optimizations / stripping don't work for 
# gcc, mingw-w64-crt and winpthreads
common_FLAGS=CFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include $(filter-out -fdata-sections -ffunction-sections -fPIC ,$(CFLAGS))' \
CXXFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include $(filter-out -fdata-sections -ffunction-sections -fPIC ,$(CXXFLAGS))' \
LDFLAGS='$(filter-out -Wl$(comma)--gc-sections ,$(LDFLAGS))'

# Common configure options for building mingw-w64-crt 
# and winpthreads somewhere else
common_CONFIGURE_OPTS=--prefix='$(PREFIX)/$(TARGET)/mingw' \
--with-sysroot='$(PREFIX)/$(TARGET)/mingw' \
$(common_FLAGS) \
RCFLAGS='-I$(PREFIX)/$(TARGET)/mingw/include'

# Point native system header dir to /mingw/include and
# compile without some optimizations / stripping
gcc_CONFIGURE_OPTS=--with-native-system-header-dir='/mingw/include' \
$(subst -I$(PREFIX)/$(TARGET)/mingw/include ,,$(common_FLAGS))

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

# version 2.37.0 requires the Meson build system which
# fail to build in a cross-compiler. See:
# https://gitlab.gnome.org/GNOME/gdk-pixbuf/issues/80
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

# upstream version is 1.5.2
matio_VERSION  := 1.5.12
matio_CHECKSUM := 8695e380e465056afa5b5e20128935afe7d50e03830f9f7778a72e1e1894d8a9
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 6.9.0-0
imagemagick_VERSION  := 6.9.10-12
imagemagick_CHECKSUM := 54549fe394598f6a7cec8cb5adc45d5d65b8b4f043745c6610693618b1372966
imagemagick_SUBDIR   := ImageMagick-$(imagemagick_VERSION)
imagemagick_FILE     := ImageMagick-$(imagemagick_VERSION).tar.xz
imagemagick_URL      := https://www.imagemagick.org/download/releases/$(imagemagick_FILE)
imagemagick_URL_2    := https://ftp.nluug.nl/ImageMagick/$(imagemagick_FILE)

# Note: static linking is broken on 2.42, if static linking is needed; stick with 2.40.20.
# See: https://gitlab.gnome.org/GNOME/librsvg/issues/159
# upstream version is 2.40.5
librsvg_VERSION  := 2.44.4
librsvg_CHECKSUM := bd913b1f598d2dec70762849e51c5db334d072648557821e3908a2c43bad5f3d
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.42.4
pango_CHECKSUM := 1d2b74cd63e8bd41961f2f8d952355aa0f9be6002b52c8aa7699d9f5da597c9d
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
poppler_VERSION  := 0.69.0
poppler_CHECKSUM := 637ff943f805f304ff1da77ba2e7f1cbd675f474941fd8ae1e0fc01a5b45a3f9
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/poppler-[0-9]*.patch)))
poppler_SUBDIR   := poppler-$(poppler_VERSION)
poppler_FILE     := poppler-$(poppler_VERSION).tar.xz
poppler_URL      := https://poppler.freedesktop.org/$(poppler_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.57.2
glib_CHECKSUM := e19f795baabb52651ddea90bb5dc8f696939e15290c3cb7cfa684d4e1628c1a8
glib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/glib-[0-9]*.patch)))
glib_SUBDIR   := glib-$(glib_VERSION)
glib_FILE     := glib-$(glib_VERSION).tar.xz
glib_URL      := https://download.gnome.org/sources/glib/$(call SHORT_PKG_VERSION,glib)/$(glib_FILE)

# upstream version is 1.14.30
libgsf_VERSION  := 1.14.44
libgsf_CHECKSUM := 68bede10037164764992970b4cb57cd6add6986a846d04657af9d5fac774ffde
libgsf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libgsf-[0-9]*.patch)))
libgsf_SUBDIR   := libgsf-$(libgsf_VERSION)
libgsf_FILE     := libgsf-$(libgsf_VERSION).tar.xz
libgsf_URL      := https://download.gnome.org/sources/libgsf/$(call SHORT_PKG_VERSION,libgsf)/$(libgsf_FILE)

# upstream version is 1.15.4
cairo_VERSION  := 1.15.14
cairo_CHECKSUM := 16566b6c015a761bb0b7595cf879b77f8de85f90b443119083c4c2769b93298d
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := https://cairographics.org/snapshots/$(cairo_FILE)

# zlib will make libzlib.dll, but we want libz.dll so we must 
# patch CMakeLists.txt
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/zlib-[0-9]*.patch)))

# upstream version is 1.5.3
libjpeg-turbo_VERSION  := 2.0.0
libjpeg-turbo_CHECKSUM := 778876105d0d316203c928fd2a0374c8c01f755d0a00b12a1c8934aeccff8868
libjpeg-turbo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/libjpeg-turbo-[0-9]*.patch)))
libjpeg-turbo_SUBDIR   := libjpeg-turbo-$(libjpeg-turbo_VERSION)
libjpeg-turbo_FILE     := libjpeg-turbo-$(libjpeg-turbo_VERSION).tar.gz
libjpeg-turbo_URL      := https://$(SOURCEFORGE_MIRROR)/project/libjpeg-turbo/$(libjpeg-turbo_VERSION)/$(libjpeg-turbo_FILE)

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
pixman_VERSION  := 0.34.0
pixman_CHECKSUM := 21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

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
define gdk-pixbuf_BUILD
    cd '$(SOURCE_DIR)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-modules \
        --with-included-loaders \
        --without-gdiplus \
        CPPFLAGS="$(CPPFLAGS) `'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
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
        CPPFLAGS="$(CPPFLAGS) `'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        LIBS="`'$(TARGET)-pkg-config' --libs jpeg-turbo`"
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' bin_PROGRAMS=
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install bin_PROGRAMS=
endef

# Upstream switched build system to CMake.
# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the 
# libjpeg API)
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DWITH_TURBOJPEG=OFF \
        -DCMAKE_INCLUDE_PATH='$(PREFIX)/$(TARGET)/include/$(PKG)' \
        -DCMAKE_LIBRARY_PATH='$(PREFIX)/$(TARGET)/lib/$(PKG)' \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

# disable GObject introspection
define pango_BUILD
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

    # Pass static Rust package to linker
    $(SED) -i 's,^deplibs_check_method=.*,deplibs_check_method="pass_all",g' $(BUILD_DIR)/libtool

    # Fix RUST_LIB linking
    $(SED) -i 's,\($$(.*_la_OBJECTS)\) \($$(.*_la_DEPENDENCIES)\),\1 $$\(RUST_LIB\) \2,g' $(SOURCE_DIR)/Makefile.in
    $(SED) -i 's,\($$(.*_la_OBJECTS)\) \($$(.*_la_LIBADD)\),\1 $$\(RUST_LIB\) \2,g' $(SOURCE_DIR)/Makefile.in

    $(MAKE) \
        -C '$(BUILD_DIR)' \
        -j '$(JOBS)' \
        RUSTUP_HOME='/usr/local/rustup' \
        RUSTFLAGS='-C panic=abort' \
        CARGO_HOME='/usr/local/cargo' \
        PATH='/usr/local/cargo/bin:$(PATH)'

    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_LIB)

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
        CPPFLAGS="$(CPPFLAGS) `'$(TARGET)-pkg-config' --cflags jpeg-turbo`" \
        LIBS="`'$(TARGET)-pkg-config' --libs jpeg-turbo`"
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
