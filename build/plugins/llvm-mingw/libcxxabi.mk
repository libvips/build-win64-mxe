# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxxabi
$(PKG)_WEBSITE  := https://libcxxabi.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := 2f92be064997fdb001cc4d00888ca93a1f553327b38919defa1565d1d732a606
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxxabi-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
