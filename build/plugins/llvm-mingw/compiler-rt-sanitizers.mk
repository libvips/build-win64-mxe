# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 12.0.0
$(PKG)_CHECKSUM := 85a8cd0a62413eaa0457d8d02f8edac38c4dc0c96c00b09dc550260c23268434
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/compiler-rt-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := compiler-rt-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_DEPS     := cc

# Note: Ubsan includes <typeinfo> from the C++ headers, so
# this has to be built after libcxx.
define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    # [major].[minor].[patch]-[label] -> [major].[minor].[patch]
    $(eval CLANG_VERSION := $(firstword $(subst -, ,$($(PKG)_VERSION))))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(BUILD_ARCH_NAME)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
        -DCOMPILER_RT_BUILD_BUILTINS=FALSE \
        -DCOMPILER_RT_BUILD_LIBFUZZER=FALSE \
        -DCOMPILER_RT_BUILD_PROFILE=FALSE \
        -DCOMPILER_RT_BUILD_MEMPROF=FALSE \
        -DSANITIZER_CXX_ABI=libc++
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' install-compiler-rt-headers -j 1

    $(INSTALL) -d '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows'

    find '$(BUILD_DIR)/lib/windows' -name 'libclang_rt.*.a' \
        -exec $(INSTALL) -m644 {} '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows' \;

    find '$(BUILD_DIR)/lib/windows' -type f -name 'libclang_rt.*.dll' \
        -exec $(INSTALL) -m644 {} '$(PREFIX)/$(TARGET)/bin' \;
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_armv7-w64-mingw32   =
$(PKG)_BUILD_aarch64-w64-mingw32 =
