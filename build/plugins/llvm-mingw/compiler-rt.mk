# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.1
$(PKG)_CHECKSUM := 087be3f1116e861cd969c9b0b0903c27028b52eaf45157276f50a9c2500687fc
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/compiler-rt-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
