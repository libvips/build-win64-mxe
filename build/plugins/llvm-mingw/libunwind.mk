# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libunwind
$(PKG)_WEBSITE  := https://clang.llvm.org/docs/Toolchain.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.1.0
$(PKG)_CHECKSUM := d29eb112d6f388a05e7fd5315923a5528489ddfc55a21cf27268a33298d0f8ee
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libunwind-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
