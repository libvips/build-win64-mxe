# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := clang
$(PKG)_WEBSITE  := https://clang.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.1
$(PKG)_CHECKSUM := 5778512b2e065c204010f88777d44b95250671103e434f9dc7363ab2e3804253
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/clang-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
