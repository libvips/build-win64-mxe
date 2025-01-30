# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_DEPS     := cc
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    $(INSTALL) -m644 '/opt/llvm-mingw/$(PROCESSOR)-w64-mingw32/bin/libclang_rt.asan_dynamic-$(BUILD_ARCH_NAME).dll' '$(PREFIX)/$(TARGET)/bin'
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_aarch64-w64-mingw32 =
