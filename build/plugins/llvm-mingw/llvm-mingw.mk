# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm-mingw
$(PKG)_WEBSITE  := https://github.com/mstorsjo/llvm-mingw
$(PKG)_DESCR    := An LLVM/Clang/LLD based mingw-w64 toolchain
$(PKG)_IGNORE   :=
# https://github.com/mstorsjo/llvm-mingw/tarball/0b68b891e012a4accc61c8173a1920ac32a83a7f
$(PKG)_VERSION  := 0b68b89
$(PKG)_CHECKSUM := 83ece8fca855f057d6c7e7163c06d4035041b33c5c574e60c166320918225a88
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/llvm-mingw-[0-9]*.patch)))
$(PKG)_GH_CONF  := mstorsjo/llvm-mingw/branches/master
$(PKG)_DEPS     := mingw-w64

# The minimum Windows version we support is Windows 7, as libc++ uses
# TryAcquireSRWLockExclusive which didn't exist until Windows 7. See:
# https://github.com/mstorsjo/llvm-mingw/commit/dcf34a9a35ee3d490a85bdec02999cf96615d406
# https://github.com/mstorsjo/llvm-mingw/blob/master/build-mingw-w64.sh#L5-L6
# Install the headers in $(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32 since
# we need to distribute the /include and /lib directories
define $(PKG)_BUILD_mingw-w64
    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    # install the usual wrappers
    $($(PKG)_PRE_BUILD)

    # install mingw-w64 headers
    $(call PREPARE_PKG_SOURCE,mingw-w64,$(BUILD_DIR))
    mkdir '$(BUILD_DIR).headers'
    cd '$(BUILD_DIR).headers' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-headers/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32' \
        --enable-idl \
        --with-default-msvcrt=ucrt \
        --with-default-win32-winnt=0x601 \
        $(mingw-w64-headers_CONFIGURE_OPTS)
    $(MAKE) -C '$(BUILD_DIR).headers' install

    # build mingw-w64-crt
    mkdir '$(BUILD_DIR).crt'
    cd '$(BUILD_DIR).crt' && '$(BUILD_DIR)/$(mingw-w64_SUBDIR)/mingw-w64-crt/configure' \
        --host='$(TARGET)' \
        --prefix='$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32' \
        --with-default-msvcrt=$(if $(findstring .debug,$(TARGET)),ucrtbased,ucrt) \
        @mingw-crt-config-opts@
    $(MAKE) -C '$(BUILD_DIR).crt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).crt' -j 1 $(INSTALL_STRIP_TOOLCHAIN)

    # Create empty dummy archives, to avoid failing when the compiler
    # driver adds "-lssp -lssp_nonshared" when linking.
    $(PREFIX)/$(BUILD)/bin/llvm-ar rcs $(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/libssp.a
    $(PREFIX)/$(BUILD)/bin/llvm-ar rcs $(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/libssp_nonshared.a
endef

define $(PKG)_PRE_BUILD
    # setup symlinks
    $(foreach EXEC, clang clang++ ld.lld llvm-objdump, \
        ln -sf '$(PREFIX)/$(BUILD)/bin/$(EXEC)' '$(PREFIX)/$(TARGET)/bin/$(EXEC)';)

    # setup target wrappers
    $(foreach EXEC, addr2line ar ranlib nm objcopy strings strip windres dlltool, \
        ln -sf '$(PREFIX)/$(BUILD)/bin/llvm-$(EXEC)' '$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-$(EXEC)'; \
        (echo '#!/bin/sh'; \
         echo 'exec "$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-$(EXEC)" "$$@"') \
                 > '$(PREFIX)/bin/$(TARGET)-$(EXEC)'; \
        chmod 0755 '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    $(foreach EXEC, clang-target ld objdump, \
        $(SED) -i -e 's|^DEFAULT_TARGET=.*|DEFAULT_TARGET=$(PROCESSOR)-w64-mingw32|' \
                  -e 's|^DIR=.*|DIR="$(PREFIX)/$(TARGET)/bin"|' \
                  -e 's|$$FLAGS "$$@"|$$FLAGS --sysroot="$(PREFIX)/$(TARGET)" "$$@"|' '$(SOURCE_DIR)/wrappers/$(EXEC)-wrapper.sh'; \
        $(INSTALL) -m755 '$(SOURCE_DIR)/wrappers/$(EXEC)-wrapper.sh' '$(PREFIX)/$(TARGET)/bin';)

    $(foreach EXEC, clang clang++ gcc g++ c++, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/clang-target-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    $(foreach EXEC, ld objdump, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/$(EXEC)-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)
endef

$(PKG)_BUILD_x86_64-w64-mingw32 = $(subst @mingw-crt-config-opts@,--disable-lib32 --enable-lib64,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_i686-w64-mingw32   = $(subst @mingw-crt-config-opts@,--enable-lib32 --disable-lib64,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_armv7-w64-mingw32   = $(subst @mingw-crt-config-opts@,--disable-lib32 --disable-lib64 --enable-libarm32,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_aarch64-w64-mingw32 = $(subst @mingw-crt-config-opts@,--disable-lib32 --disable-lib64 --enable-libarm64,$($(PKG)_BUILD_mingw-w64))
