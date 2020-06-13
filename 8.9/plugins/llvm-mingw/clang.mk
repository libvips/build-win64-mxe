# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := clang
$(PKG)_WEBSITE  := https://clang.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := 885b062b00e903df72631c5f98b9579ed1ed2790f74e5646b4234fa084eacb21
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/clang-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_TYPE     := source-only
$(PKG)_TARGETS  := $(BUILD)
