# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxxabi
$(PKG)_WEBSITE  := https://libcxxabi.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.1
$(PKG)_CHECKSUM := 4a697056a5c08621a8380dcaf3836525835aa76b3008d9e8f27abf9270bf683f
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxxabi-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
