# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := lld
$(PKG)_WEBSITE  := https://lld.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 11.0.0-rc3
$(PKG)_CHECKSUM := c8950ad0c4d45d965ce91ed230ea9777c02245a1d6a7703cec7025932df2e734
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/lld-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$(subst -,,$($(PKG)_VERSION)).src
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
