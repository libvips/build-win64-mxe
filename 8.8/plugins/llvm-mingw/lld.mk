# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lld
$(PKG)_WEBSITE  := https://lld.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.0
$(PKG)_CHECKSUM := 31c6748b235d09723fb73fea0c816ed5a3fab0f96b66f8fbc546a0fcc8688f91
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lld-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/tags, llvmorg-
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_URL      := https://releases.llvm.org/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
