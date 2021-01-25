# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxx
$(PKG)_WEBSITE  := https://libcxx.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.1
$(PKG)_CHECKSUM := 9fd5f669621ffea88a2b93e3d99f3a958b5defb954f71bf754709b63275f5e3d
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxx-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
