# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cargo-c
$(PKG)_WEBSITE  := https://github.com/lu-zero/cargo-c
$(PKG)_DESCR    := cargo applet to build and install C-ABI compatibile libraries
$(PKG)_TYPE     := meta
$(PKG)_GH_CONF  :=
$(PKG)_TARGETS  := $(BUILD)
$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD_$(BUILD)
    $(info $(PKG) is provided by the prebuilt Dockerfile)
endef
