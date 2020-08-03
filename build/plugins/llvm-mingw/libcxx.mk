# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxx
$(PKG)_WEBSITE  := https://libcxx.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc1
$(PKG)_CHECKSUM := c4d68d78d3e751f0c0c64fd143e25094880be192a367f750628ef357488fb867
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxx-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
