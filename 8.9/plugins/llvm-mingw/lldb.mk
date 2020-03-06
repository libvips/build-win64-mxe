# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lldb
$(PKG)_WEBSITE  := https://lldb.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.1
$(PKG)_CHECKSUM := 8a7b9fd795c31a3e3cba6ce1377a2ae5c67376d92888702ce27e26f0971beb09
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lldb-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
