# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxxabi
$(PKG)_WEBSITE  := https://libcxxabi.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.1.0
$(PKG)_CHECKSUM := 143193ed80f8fa4d85211d6704a90789fb36aa65b69fd0c382a9f05ec370ecab
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxxabi-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
