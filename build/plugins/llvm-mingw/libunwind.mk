# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libunwind
$(PKG)_WEBSITE  := https://clang.llvm.org/docs/Toolchain.html
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 9.0.1
$(PKG)_CHECKSUM := 535a106a700889274cc7b2f610b2dcb8fc4b0ea597c3208602d7d037141460f1
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libunwind-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_DEPS     := llvm-mingw compiler-rt

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_COMPILER_CHECKED=TRUE \
        -DCMAKE_AR='$(PREFIX)/$(TARGET)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(TARGET)/bin/llvm-ranlib' \
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
