# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxxabi
$(PKG)_WEBSITE  := https://libcxxabi.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc1
$(PKG)_CHECKSUM := 1d52447a9f3c4bde7d2a877f395902269f2815403b14275df9728ed8ab4de1c3
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxxabi-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
