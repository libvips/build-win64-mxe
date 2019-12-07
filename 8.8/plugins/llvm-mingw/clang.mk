# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := clang
$(PKG)_WEBSITE  := https://clang.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.0
$(PKG)_CHECKSUM := 7ba81eef7c22ca5da688fdf9d88c20934d2d6b40bfe150ffd338900890aa4610
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/clang-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/tags, llvmorg-
$(PKG)_SUBDIR   := cfe-$($(PKG)_VERSION).src
$(PKG)_FILE     := cfe-$($(PKG)_VERSION).src.tar.xz
$(PKG)_URL      := https://releases.llvm.org/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
