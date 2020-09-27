# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lldb
$(PKG)_WEBSITE  := https://lldb.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := 3a16bbbbdf4efc1f69835b502d493b3dfc9841c46645eb89bd982b94ed71a648
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lldb-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
