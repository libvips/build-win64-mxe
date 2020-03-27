# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxxabi
$(PKG)_WEBSITE  := https://libcxxabi.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := e71bac75a88c9dde455ad3f2a2b449bf745eafd41d2d8432253b2964e0ca14e1
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxxabi-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
