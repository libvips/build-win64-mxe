# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := clang
$(PKG)_WEBSITE  := https://clang.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := 8d7b47cca01d1bc07e8d47c0fd1ab7a6d386681631ae8667d056bd9bec269d03
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/clang-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
