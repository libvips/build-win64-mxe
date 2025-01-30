# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_DEPS     := cc
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    $(info $(PKG) is provided by the prebuilt Dockerfile)
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_aarch64-w64-mingw32 =
