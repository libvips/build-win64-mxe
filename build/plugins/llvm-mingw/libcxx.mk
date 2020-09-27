# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxx
$(PKG)_WEBSITE  := https://libcxx.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := 27a7f12aed0688a0724ca1859a7b85f43742ad5b4fd89ea64e94fd9dac799fa6
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxx-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
