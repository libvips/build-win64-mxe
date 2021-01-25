# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lldb
$(PKG)_WEBSITE  := https://lldb.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.1
$(PKG)_CHECKSUM := e8d38917d079356fc1200676dfb370e16f3ee9cbdd092dd31e59d080ac5ef2fb
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lldb-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
