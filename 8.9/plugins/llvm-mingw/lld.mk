# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lld
$(PKG)_WEBSITE  := https://lld.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.1
$(PKG)_CHECKSUM := 86262bad3e2fd784ba8c5e2158d7aa36f12b85f2515e95bc81d65d75bb9b0c82
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lld-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
