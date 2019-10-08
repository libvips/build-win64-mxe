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
gdk-pixbuf_VERSION  := 2.40.0
gdk-pixbuf_CHECKSUM := 1582595099537ca8ff3b99c6804350b4c058bb8ad67411bbaae024ee7cead4e6
gdk-pixbuf_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gdk-pixbuf-[0-9]*.patch)))
gdk-pixbuf_SUBDIR   := gdk-pixbuf-$(gdk-pixbuf_VERSION)
gdk-pixbuf_FILE     := gdk-pixbuf-$(gdk-pixbuf_VERSION).tar.xz
gdk-pixbuf_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,gdk-pixbuf)/$(gdk-pixbuf_FILE)

# upstream version is 1.5.2
# cannot use GH_CONF:
# matio_GH_CONF  := tbeu/matio/releases,v
matio_VERSION  := 1.5.17
matio_CHECKSUM := 5e455527d370ab297c4abe5a2ab4d599c93ac7c1a0c85d841cc5c22f8221c400
matio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/matio-[0-9]*.patch)))
matio_SUBDIR   := matio-$(matio_VERSION)
matio_FILE     := matio-$(matio_VERSION).tar.gz
matio_URL      := https://github.com/tbeu/matio/releases/download/v$(matio_VERSION)/$(matio_FILE)

# upstream version is 7, we want ImageMagick 6
imagemagick_VERSION  := 6.9.10-68
imagemagick_CHECKSUM := 2caa3d8d1f65e733de30d1f537e57991ff3adb3edb5b60afa9cd0f6e0a20945f
imagemagick_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/imagemagick-[0-9]*.patch)))
imagemagick_GH_CONF  := ImageMagick/ImageMagick6/tags

# upstream version is 2.4
x265_VERSION  := 3.2
x265_CHECKSUM := 364d79bcd56116a9e070fdeb1d9d2aaef1a786b4970163fb56ff0991a183133b
x265_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/x265-[0-9]*.patch)))
x265_SUBDIR   := x265_$(x265_VERSION)
x265_FILE     := x265_$(x265_VERSION).tar.gz
x265_URL      := https://bitbucket.org/multicoreware/x265/downloads/$(x265_FILE)
x265_URL_2    := ftp://ftp.videolan.org/pub/videolan/x265/$(x265_FILE)

# upstream version is 2.40.5
librsvg_VERSION  := 2.46.1
librsvg_CHECKSUM := 2da1f2547a63a24ead121ad345011d5fd4f038ef46f74712ec82a1e85ec67643
librsvg_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/librsvg-[0-9]*.patch)))
librsvg_SUBDIR   := librsvg-$(librsvg_VERSION)
librsvg_FILE     := librsvg-$(librsvg_VERSION).tar.xz
librsvg_URL      := https://download.gnome.org/sources/librsvg/$(call SHORT_PKG_VERSION,librsvg)/$(librsvg_FILE)

# upstream version is 1.37.4
pango_VERSION  := 1.44.6
pango_CHECKSUM := 3e1e41ba838737e200611ff001e3b304c2ca4cdbba63d200a20db0b0ddc0f86c
pango_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pango-[0-9]*.patch)))
pango_SUBDIR   := pango-$(pango_VERSION)
pango_FILE     := pango-$(pango_VERSION).tar.xz
pango_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,pango)/$(pango_FILE)

# upstream version is 1.0.5
# cannot use GH_CONF:
# fribidi_GH_CONF  := fribidi/fribidi/releases,v
fribidi_VERSION  := 1.0.7
fribidi_CHECKSUM := 5ab5f21e9f2fc57b4b40f8ea8f14dba78a5cc46d9cf94bc5e00a58e6886a935d
fribidi_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/fribidi-[0-9]*.patch)))
fribidi_SUBDIR   := fribidi-$(fribidi_VERSION)
fribidi_FILE     := fribidi-$(fribidi_VERSION).tar.bz2
fribidi_URL      := https://github.com/fribidi/fribidi/releases/download/v$(fribidi_VERSION)/$(fribidi_FILE)

# Use the mutex helper from mingw-std-threads
poppler_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/poppler-[0-9]*.patch)))

# upstream version is 0.6.2
libcroco_VERSION  := 0.6.13
libcroco_CHECKSUM := 767ec234ae7aa684695b3a735548224888132e063f92db585759b422570621d4
libcroco_SUBDIR   := libcroco-$(libcroco_VERSION)
libcroco_FILE     := libcroco-$(libcroco_VERSION).tar.xz
libcroco_URL      := https://download.gnome.org/sources/libcroco/$(call SHORT_PKG_VERSION,libcroco)/$(libcroco_FILE)

# upstream version is 2.50.2
glib_VERSION  := 2.63.0
glib_CHECKSUM := d974d7f514358ee6f69451826a215578141701075924108da311ec2c8dc01056
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

# upstream version is 1.16.0
cairo_VERSION  := 1.17.2
cairo_CHECKSUM := 6b70d4655e2a47a22b101c666f4b29ba746eda4aa8a0f7255b32b2e9408801df
cairo_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cairo-[0-9]*.patch)))
cairo_SUBDIR   := cairo-$(cairo_VERSION)
cairo_FILE     := cairo-$(cairo_VERSION).tar.xz
cairo_URL      := http://cairographics.org/snapshots/$(cairo_FILE)

# zlib will make libzlib.dll, but we want libz.dll so we must 
# patch CMakeLists.txt
zlib_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/zlib-[0-9]*.patch)))

# upstream version is 2.2.0
# cannot use GH_CONF:
# openexr_GH_CONF  := openexr/openexr/tags
openexr_VERSION  := 2.4.0
openexr_CHECKSUM := 4904c5ea7914a58f60a5e2fbc397be67e7a25c380d7d07c1c31a3eefff1c92f1
openexr_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/openexr-[0-9]*.patch)))
openexr_SUBDIR   := openexr-$(openexr_VERSION)
openexr_FILE     := openexr-$(openexr_VERSION).tar.gz
openexr_URL      := https://github.com/openexr/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 2.2.0
# cannot use GH_CONF:
# ilmbase_GH_CONF  := openexr/openexr/tags
ilmbase_VERSION  := 2.4.0
ilmbase_CHECKSUM := 4904c5ea7914a58f60a5e2fbc397be67e7a25c380d7d07c1c31a3eefff1c92f1
ilmbase_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/ilmbase-[0-9]*.patch)))
ilmbase_SUBDIR   := openexr-$(openexr_VERSION)
ilmbase_FILE     := openexr-$(openexr_VERSION).tar.gz
ilmbase_URL      := https://github.com/openexr/openexr/archive/v$(openexr_VERSION).tar.gz

# upstream version is 3410
cfitsio_VERSION  := 3450
cfitsio_CHECKSUM := bf6012dbe668ecb22c399c4b7b2814557ee282c74a7d5dc704eb17c30d9fb92e
cfitsio_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/cfitsio-[0-9]*.patch)))
cfitsio_SUBDIR   := cfitsio
cfitsio_FILE     := cfitsio$(cfitsio_VERSION).tar.gz
cfitsio_URL      := https://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/$(cfitsio_FILE)
cfitsio_URL_2    := https://mirrorservice.org/sites/distfiles.macports.org/cfitsio/$(cfitsio_FILE)

# upstream version is 0.33.6
pixman_VERSION  := 0.38.4
pixman_CHECKSUM := da66d6fd6e40aee70f7bd02e4f8f76fc3f006ec879d346bae6a723025cfbdde7
pixman_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/pixman-[0-9]*.patch)))
pixman_SUBDIR   := pixman-$(pixman_VERSION)
pixman_FILE     := pixman-$(pixman_VERSION).tar.gz
pixman_URL      := https://cairographics.org/releases/$(pixman_FILE)

# upstream version is 2.13.1
fontconfig_VERSION  := 2.13.92
fontconfig_CHECKSUM := 506e61283878c1726550bc94f2af26168f1e9f2106eac77eaaf0b2cdfad66e4e
fontconfig_SUBDIR   := fontconfig-$(fontconfig_VERSION)
fontconfig_FILE     := fontconfig-$(fontconfig_VERSION).tar.xz
fontconfig_URL      := https://www.freedesktop.org/software/fontconfig/release/$(fontconfig_FILE)

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
#  Replaced: jpeg with libjpeg-turbo
# ImageMagick:
#  Added: libxml2, openjpeg
#  Removed: bzip2, ffmpeg, fftw, freetype, jasper, liblqr-1, libltdl, libpng, openexr, tiff, zlib
#  Replaced: jpeg with libjpeg-turbo
# IlmBase:
#  Added: pthreads
# Pango:
#  Added: fribidi
# Poppler:
#  Removed: curl, qtbase, libwebp
#  Added: mingw-std-threads, libjpeg-turbo, lcms
# libwebp:
#  Added: gettext
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
tiff_DEPS               := cc libjpeg-turbo libwebp xz zlib
imagemagick_DEPS        := cc libxml2 openjpeg lcms libjpeg-turbo pthreads
ilmbase_DEPS            := cc pthreads
pango_DEPS              := $(pango_DEPS) fribidi
poppler_DEPS            := cc mingw-std-threads cairo libjpeg-turbo freetype glib openjpeg lcms libpng tiff zlib
libwebp_DEPS            := $(libwebp_DEPS) gettext
cairo_DEPS              := cc fontconfig freetype-bootstrap glib libpng pixman
x265_DEPS               := cc $(BUILD)~nasm

## Override build scripts

# icu will pull in standard linux headers, which we don't want,
# build with CMake.
define harfbuzz_BUILD
    # mman-win32 is only a partial implementation
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DHB_HAVE_GLIB=ON \
        -DHB_HAVE_FREETYPE=ON \
        -DHB_HAVE_ICU=OFF \
        -DHAVE_SYS_MMAN_H=OFF \
        -DHB_BUILD_UTILS=OFF \
        -DHB_BUILD_TESTS=OFF \
        '$(SOURCE_DIR)'
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

# build pixman with the Meson build system
define pixman_BUILD
    '$(TARGET)-meson' \
        --libdir='lib' \
        --bindir='bin' \
        --libexecdir='bin' \
        --includedir='include' \
        -Dgtk=disabled \
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
    $(eval GIT_REVISION=$(shell $(SED) -n 's/MAGICK_GIT_REVISION=\(.*\)/\1/p' $(SOURCE_DIR)/configure))
    $(SED) -i 's|\(\[magick_git_revision\], \).*)|\1[$(GIT_REVISION)])|' $(SOURCE_DIR)/configure.ac

    # need to regenerate the configure script
    cd '$(SOURCE_DIR)' && autoreconf -fi

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
        --disable-largefile \
        --disable-opencl \
        --disable-openmp \
        ax_cv_check_cl_libcl=no
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

# WITH_TURBOJPEG=OFF turns off a library we don't use (we just use the 
# libjpeg API)
define libjpeg-turbo_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DWITH_TURBOJPEG=OFF \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DCMAKE_ASM_NASM_COMPILER=$(TARGET)-yasm \
        '$(SOURCE_DIR)'
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
        -Dintrospection=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef

# compile with the Rust toolchain 
define librsvg_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-pixbuf-loader \
        --disable-gtk-doc \
        --disable-introspection \
        --disable-tools \
        LIBS='-lws2_32 -luserenv' \
        RUST_TARGET=$(firstword $(subst -, ,$(TARGET)))-pc-windows-gnu \
        AR='$(TARGET)-ar' \
        NM='$(TARGET)-nm'

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
    # Add missing files
    touch '$(SOURCE_DIR)/IlmBase'/{NEWS,AUTHORS,ChangeLog,README}

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
        -DBUILD_TESTING=OFF \
        -DOPENEXR_BUILD_UTILS=OFF \
        -DOPENEXR_INSTALL_PKG_CONFIG=ON \
        '$(SOURCE_DIR)/OpenEXR'

    # build the code generator manually
    cd '$(SOURCE_DIR)/OpenEXR/IlmImf/' && $(BUILD_CXX) -O2 \
        -I'$(SOURCE_DIR)/IlmBase/include/OpenEXR' \
        -L'$(SOURCE_DIR)/IlmBase/lib' \
        b44ExpLogTable.cpp \
        -lHalf \
        -o b44ExpLogTable
    '$(SOURCE_DIR)/OpenEXR/IlmImf/b44ExpLogTable' > '$(SOURCE_DIR)/OpenEXR/IlmImf/b44ExpLogTable.h'
    cd '$(SOURCE_DIR)/OpenEXR/IlmImf/' && $(BUILD_CXX) -O2 \
        -I. \
        -I'$(BUILD_DIR)/config' \
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
    # do the first build step by hand, because programs are built that
    # generate source files
    mkdir -p '$(BUILD_DIR)/Half'
    cd '$(SOURCE_DIR)/IlmBase/Half' && $(BUILD_CXX) eLut.cpp -o eLut
    '$(SOURCE_DIR)/IlmBase/Half/eLut' > '$(BUILD_DIR)/Half/eLut.h'
    cd '$(SOURCE_DIR)/IlmBase/Half' && $(BUILD_CXX) toFloat.cpp -o toFloat
    '$(SOURCE_DIR)/IlmBase/Half/toFloat' > '$(BUILD_DIR)/Half/toFloat.h'

    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DILMBASE_FORCE_CXX03=ON \
        -DBUILD_TESTING=OFF \
        -DBUILD_SHARED_LIBS=OFF \
        -DILMBASE_INSTALL_PKG_CONFIG=ON \
        '$(SOURCE_DIR)/IlmBase'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef

define cfitsio_BUILD_SHARED
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBUILD_SHARED_LIBS=ON \
        '$(SOURCE_DIR)'

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
