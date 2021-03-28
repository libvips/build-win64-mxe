PKG             := libheif
$(PKG)_WEBSITE  := http://www.libheif.org/
$(PKG)_DESCR    := libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.11.0
$(PKG)_CHECKSUM := c550938f56ff6dac83702251a143f87cb3a6c71a50d8723955290832d9960913
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := strukturag/libheif/releases,v
$(PKG)_DEPS     := cc dav1d rav1e

define $(PKG)_BUILD
    # Disable multithreading when building with Win32 threads to
    # avoid a dependency on mingw-std-threads (which we only use
    # in the "all" variant). Disabling multithreading only affects
    # decoding tiled HEIF images, so it should be fine.
    # TODO(kleisauke): --disable-dav1d option missing?
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gdk-pixbuf \
        --disable-go \
        --disable-examples \
        $(if $(IS_AOM), --disable-rav1e) \
        $(if $(IS_HEVC),, --disable-libde265) \
        $(if $(IS_HEVC),, --disable-x265) \
        $(if $(WIN32_THREADS), --disable-multithreading)

    # remove -nostdlib from linker commandline options
    # https://debbugs.gnu.org/cgi/bugreport.cgi?bug=27866
    $(if $(IS_LLVM), \
        $(SED) -i '/^archive_cmds=/s/\-nostdlib//g' '$(BUILD_DIR)/libtool')

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef
