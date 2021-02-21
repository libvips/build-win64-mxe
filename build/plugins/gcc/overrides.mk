$(PLUGIN_HEADER)

IS_GCC := $(true)

## GCC bootstrap options

# Override GCC patches with our own patches
gcc_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gcc-[0-9]*.patch)))

# Remove $(BUILD)~zstd since we do not need LTO compression
gcc_DEPS := $(filter-out $(BUILD)~zstd,$(gcc_DEPS))

# We do not need OpenMP, so build with --disable-libgomp
# and compile without optimizations / stripping.
_gcc_CONFIGURE_OPTS=--with-build-sysroot='$(PREFIX)/$(TARGET)' \
--disable-libgomp \
CFLAGS='' \
CXXFLAGS='' \
LDFLAGS=''

## Update dependencies

# upstream version is 2.28 (released on 2017-03-06)
binutils_VERSION  := 2.35.1
binutils_CHECKSUM := 3ced91db9bf01182b7e420eab68039f2083aed0a214c0424e257eae3ddee8607
binutils_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/binutils-[0-9]*.patch)))
binutils_SUBDIR   := binutils-$(binutils_VERSION)
binutils_FILE     := binutils-$(binutils_VERSION).tar.xz
binutils_URL      := https://ftp.gnu.org/gnu/binutils/$(binutils_FILE)
binutils_URL_2    := https://ftpmirror.gnu.org/binutils/$(binutils_FILE)

## Override sub-dependencies

ilmbase_DEPS  := $(ilmbase_DEPS) mingw-std-threads
libde265_DEPS := $(libde265_DEPS) mingw-std-threads
openexr_DEPS  := $(openexr_DEPS) mingw-std-threads
poppler_DEPS  := $(poppler_DEPS) mingw-std-threads

## Override build scripts

# The minimum Windows version we support is Windows 7, so build with:
#   --with-default-msvcrt=msvcrt \
#   --with-default-win32-winnt=0x601 \
# Install the headers in $(PREFIX)/$(TARGET)/mingw since
# we need to distribute the /include and /lib directories
# Note: Building with --with-default-msvcrt=ucrt breaks
# compatibility with the prebuilt Rust binaries that
# is built in msvcrt mode.
define gcc_BUILD_mingw-w64
    # install mingw-w64 headers
    $(call PREPARE_PKG_SOURCE,mingw-w64,$(BUILD_DIR))
    mkdir '$(BUILD_DIR).headers'
    cd '$(BUILD_DIR).headers' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-headers/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/mingw' \
        --enable-idl \
        --with-default-msvcrt=msvcrt \
        --with-default-win32-winnt=0x601 \
        $(mingw-w64-headers_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).headers' install

    # build standalone gcc
    $(gcc_CONFIGURE)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-gcc
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)-gcc

    # build mingw-w64-crt
    mkdir '$(BUILD_DIR).crt'
    cd '$(BUILD_DIR).crt' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-crt/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/mingw' \
        --with-default-msvcrt=msvcrt \
        @gcc-crt-config-opts@
    $(MAKE) -C '$(BUILD_DIR).crt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).crt' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build posix threads
    mkdir '$(BUILD_DIR).pthreads'
    cd '$(BUILD_DIR).pthreads' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-libraries/winpthreads/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --prefix='$(PREFIX)/$(TARGET)/mingw'
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).pthreads' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # build rest of gcc
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' all-target-libstdc++-v3
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    $(gcc_POST_BUILD)
endef
