# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxx
$(PKG)_WEBSITE  := https://libcxx.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0
$(PKG)_CHECKSUM := 6c1ee6690122f2711a77bc19241834a9219dda5036e1597bfa397f341a9b8b7a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxx-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
