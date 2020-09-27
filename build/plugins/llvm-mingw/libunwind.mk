# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libunwind
$(PKG)_WEBSITE  := https://clang.llvm.org/docs/Toolchain.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := ce81f9d0c9a075fa64dadd8b1f8037815555419b4c59f89b52e030fa9e5f40b3
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libunwind-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
