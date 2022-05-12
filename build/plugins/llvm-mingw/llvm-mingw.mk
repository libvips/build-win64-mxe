# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm-mingw
$(PKG)_WEBSITE  := https://github.com/mstorsjo/llvm-mingw
$(PKG)_DESCR    := An LLVM/Clang/LLD based mingw-w64 toolchain
$(PKG)_IGNORE   :=
# https://github.com/mstorsjo/llvm-mingw/tarball/83d84ab79b42b267948f7fbbbd99065ec781fb5f
$(PKG)_VERSION  := 83d84ab
$(PKG)_CHECKSUM := 7519fa5271a07ea3a617ca36c098fe6fd11453b48706dbdc9236fd1ffd152ef3
# TODO(kleisauke): Remove this if we omit any dots from our target
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
endef

define $(PKG)_PRE_BUILD
    # setup symlinks
    $(foreach EXEC, clang clang++ ld.lld llvm-objdump, \
        ln -sf '$(PREFIX)/$(BUILD)/bin/$(EXEC)' '$(PREFIX)/$(TARGET)/bin/$(EXEC)';)

    # setup target wrappers
    # Can't symlink here, it will break the basename detection of LLVM. See:
    # sys::path::stem("x86_64-w64-mingw32.shared-ranlib"); -> x86_64-w64-mingw32
    # TODO(kleisauke): Remove this if we omit any dots from our target, see:
    # https://github.com/llvm/llvm-project/blob/llvmorg-14.0.3/llvm/tools/llvm-ar/llvm-ar.cpp#L1285-L1304
    $(foreach EXEC, addr2line ar cvtres nm objcopy ranlib rc strings strip, \
        (echo '#!/bin/sh'; \
         echo 'exec "$(PREFIX)/$(BUILD)/bin/llvm-$(EXEC)" "$$@"') \
                 > '$(PREFIX)/bin/$(TARGET)-$(EXEC)'; \
        chmod 0755 '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    # We need to pass some additional arguments for windres
    # TODO(kleisauke): Remove this if we omit any dots from our target, see:
    # https://github.com/llvm/llvm-project/blob/llvmorg-14.0.3/llvm/tools/llvm-rc/llvm-rc.cpp#L266-L277
    (echo '#!/bin/sh'; \
     echo 'exec "$(PREFIX)/$(BUILD)/bin/llvm-windres" \
         --preprocessor-arg="--sysroot=$(PREFIX)/$(TARGET)" \
         --target="$(firstword $(subst ., ,$(TARGET)))" "$$@"') \
             > '$(PREFIX)/bin/$(TARGET)-windres'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-windres'

    # And we need to hint the target machine for dlltool, ouch.
    # i686 -> i386
    # x86_64 -> i386:x86-64
    # armv7 -> arm
    # aarch64 -> arm64
    # TODO(kleisauke): Remove this if we omit any dots from our target, see:
    # https://github.com/llvm/llvm-project/blob/llvmorg-14.0.3/llvm/lib/ToolDrivers/llvm-dlltool/DlltoolDriver.cpp#L97-L108
    $(eval DLLTOOL_ARCH := $(strip \
        $(if $(findstring i686,$(PROCESSOR)),i386, \
        $(if $(findstring x86_64,$(PROCESSOR)),i386:x86-64, \
        $(if $(findstring armv7,$(PROCESSOR)),arm, \
        $(if $(findstring aarch64,$(PROCESSOR)),arm64, \
        $(PROCESSOR)))))))
    (echo '#!/bin/sh'; \
     echo 'exec "$(PREFIX)/$(BUILD)/bin/llvm-dlltool" \
         -m $(DLLTOOL_ARCH) "$$@"') \
             > '$(PREFIX)/bin/$(TARGET)-dlltool'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-dlltool'

    $(foreach EXEC, clang-target ld objdump, \
        $(SED) -i -e 's|^DEFAULT_TARGET=.*|DEFAULT_TARGET=$(TARGET)|' \
                  -e 's|^DIR=.*|DIR="$(PREFIX)/$(TARGET)/bin"|' '$(SOURCE_DIR)/wrappers/$(EXEC)-wrapper.sh'; \
        $(INSTALL) -m755 '$(SOURCE_DIR)/wrappers/$(EXEC)-wrapper.sh' '$(PREFIX)/$(TARGET)/bin';)

    $(foreach EXEC, clang clang++ gcc g++ cc c99 c11 c++, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/clang-target-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    $(foreach EXEC, ld objdump, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/$(EXEC)-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)
endef

$(PKG)_BUILD_x86_64-w64-mingw32 = $(subst @mingw-crt-config-opts@,--disable-lib32 --enable-lib64,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_i686-w64-mingw32   = $(subst @mingw-crt-config-opts@,--enable-lib32 --disable-lib64,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_armv7-w64-mingw32   = $(subst @mingw-crt-config-opts@,--disable-lib32 --disable-lib64 --enable-libarm32,$($(PKG)_BUILD_mingw-w64))
$(PKG)_BUILD_aarch64-w64-mingw32 = $(subst @mingw-crt-config-opts@,--disable-lib32 --disable-lib64 --enable-libarm64,$($(PKG)_BUILD_mingw-w64))
