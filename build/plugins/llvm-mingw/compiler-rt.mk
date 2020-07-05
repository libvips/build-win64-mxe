# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := 6a7da64d3a0a7320577b68b9ca4933bdcab676e898b759850e827333c3282c75
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/compiler-rt-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
