$(PLUGIN_HEADER)

IS_GCC := $(true)

## GCC bootstrap options

# Override GCC patches with our own patches
gcc_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/gcc-[0-9]*.patch)))

# Build GCC with --disable-libgomp, since we do not need OpenMP.
_gcc_CONFIGURE_OPTS= \
    --with-zstd='$(PREFIX)/$(BUILD)' \
    --with-build-sysroot='$(PREFIX)/$(TARGET)' \
    --disable-libgomp

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
    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

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

    # Ensure LTO plugin is used for the GNU ar, nm and ranlib utils, see:
    # https://stackoverflow.com/a/25878408/10952119
    $(foreach EXEC, ar nm ranlib, \
        mv '$(PREFIX)/bin/$(TARGET)-$(EXEC)' '$(PREFIX)/bin/$(TARGET)-$(EXEC)-nonlto'; \
        (echo '#!/bin/sh'; \
         echo 'exec "$(PREFIX)/bin/$(TARGET)-$(EXEC)-nonlto" --plugin "$(PREFIX)/libexec/gcc/$(TARGET)/$(gcc_VERSION)/liblto_plugin.so" "$$@"') \
                 > '$(PREFIX)/bin/$(TARGET)-$(EXEC)'; \
        chmod 0755 '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)
endef
