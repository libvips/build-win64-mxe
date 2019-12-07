# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.0
$(PKG)_CHECKSUM := 56e4cd96dd1d8c346b07b4d6b255f976570c6f2389697347a6c3dcb9e820d10e
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/compiler-rt-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/tags, llvmorg-
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_URL      := https://releases.llvm.org/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := llvm-mingw

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)/lib/builtins' \
        -DCMAKE_AR='$(PREFIX)/$(TARGET)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(TARGET)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR))-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'

    mkdir -p '$(PREFIX)/$(TARGET)/lib/clang/$($(PKG)_VERSION)/lib/windows'

    # armv7 -> arm
    $(if $(findstring armv7,$(PROCESSOR)),\
        cp '$(BUILD_DIR)/lib/windows/libclang_rt.builtins-armv7.a' \
            '$(PREFIX)/$(TARGET)/lib/clang/$($(PKG)_VERSION)/lib/windows/libclang_rt.builtins-arm.a' \
    $(else), \
        cp '$(BUILD_DIR)/lib/windows/libclang_rt.builtins-$(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)).a' \
            '$(PREFIX)/$(TARGET)/lib/clang/$($(PKG)_VERSION)/lib/windows')

endef
