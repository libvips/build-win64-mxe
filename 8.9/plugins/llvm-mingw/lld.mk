# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lld
$(PKG)_WEBSITE  := https://lld.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := b9a0d7c576eeef05bc06d6e954938a01c5396cee1d1e985891e0b1cf16e3d708
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lld-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
