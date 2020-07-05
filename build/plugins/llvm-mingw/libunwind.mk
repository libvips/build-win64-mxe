# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libunwind
$(PKG)_WEBSITE  := https://clang.llvm.org/docs/Toolchain.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := 09dc5ecc4714809ecf62908ae8fe8635ab476880455287036a2730966833c626
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libunwind-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_DEPS     := llvm-mingw compiler-rt-builtins

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_COMPILER_CHECKED=TRUE \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCXX_SUPPORTS_CXX11=TRUE \
        -DCXX_SUPPORTS_CXX_STD=TRUE \
        -DLIBUNWIND_USE_COMPILER_RT=TRUE \
        -DLIBUNWIND_ENABLE_THREADS=TRUE \
        -DLIBUNWIND_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBUNWIND_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBUNWIND_ENABLE_CROSS_UNWINDING=FALSE \
        -DCMAKE_CXX_FLAGS='$(CXXFLAGS) -Wno-dll-attribute-on-redeclaration' \
        -DCMAKE_C_FLAGS='$(CFLAGS) -Wno-dll-attribute-on-redeclaration'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install/strip

    $(if $(BUILD_SHARED),\
        cp '$(BUILD_DIR)/lib/libunwind.dll' '$(PREFIX)/$(TARGET)/bin')
endef
