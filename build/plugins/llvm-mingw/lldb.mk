# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lldb
$(PKG)_WEBSITE  := https://lldb.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc1
$(PKG)_CHECKSUM := 70cf7c4157021b3a95f23aafb6ea361913166f12afa8d43f63595f53c672ebef
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lldb-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
