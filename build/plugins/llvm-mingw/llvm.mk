# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm
$(PKG)_WEBSITE  := https://llvm.org/
$(PKG)_DESCR    := A collection of modular and reusable compiler and toolchain technologies
$(PKG)_IGNORE   :=
# This version needs to be in-sync with the compiler-rt-sanitizers package
$(PKG)_VERSION  := 19.1.4
$(PKG)_CHECKSUM := 3aa2d2d2c7553164ad5c6f3b932b31816e422635e18620c9349a7da95b98d811
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/llvm-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases/latest,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-project-$($(PKG)_VERSION).src
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.xz
# This is needed to properly override: https://github.com/mxe/mxe/blob/master/src/llvm.mk#L11
$(PKG)_URL      := https://github.com/llvm/llvm-project/releases/download/llvmorg-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := $(BUILD)~$(PKG) llvm-mingw
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) := cmake

define $(PKG)_BUILD_$(BUILD)
    # Unexport target specific compiler / linker flags
    $(eval unexport CFLAGS)
    $(eval unexport CXXFLAGS)
    $(eval unexport LDFLAGS)

    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)/llvm' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_ASSERTIONS=OFF \
        -DLLVM_ENABLE_PROJECTS='clang;lld;lldb' \
        -DLLVM_TARGETS_TO_BUILD='AArch64;X86' \
        -DLLVM_TOOLCHAIN_TOOLS='llvm-ar;llvm-config;llvm-ranlib;llvm-objdump;llvm-rc;llvm-cvtres;llvm-nm;llvm-strings;llvm-readobj;llvm-dlltool;llvm-pdbutil;llvm-objcopy;llvm-strip;llvm-cov;llvm-profdata;llvm-addr2line;llvm-symbolizer;llvm-windres' \
        -DLLVM_BUILD_DOCS=OFF \
        -DLLVM_BUILD_EXAMPLES=OFF \
        -DLLVM_BUILD_TESTS=OFF \
        -DLLVM_BUILD_UTILS=OFF \
        -DLLVM_ENABLE_BINDINGS=OFF \
        -DLLVM_ENABLE_DOXYGEN=OFF \
        -DLLVM_ENABLE_OCAMLDOC=OFF \
        -DLLVM_ENABLE_SPHINX=OFF \
        -DLLVM_INCLUDE_DOCS=OFF \
        -DLLVM_INCLUDE_EXAMPLES=OFF \
        -DLLVM_INCLUDE_TESTS=OFF \
        -DLLVM_INCLUDE_UTILS=OFF \
        -DLLDB_ENABLE_LIBEDIT=OFF \
        -DLLDB_ENABLE_PYTHON=OFF \
        -DLLDB_ENABLE_CURSES=OFF \
        -DLLDB_ENABLE_LUA=OFF \
        -DLLDB_INCLUDE_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))
endef

define $(PKG)_BUILD_COMPILER_RT
    $(eval CLANG_RESOURCE_DIR := $(shell $(PREFIX)/$(BUILD)/bin/clang --print-resource-dir))

    mkdir '$(BUILD_DIR).compiler-rt'
    cd '$(BUILD_DIR).compiler-rt' && $(TARGET)-cmake '$(SOURCE_DIR)/compiler-rt/lib/builtins' \
        -DCMAKE_INSTALL_PREFIX='$(CLANG_RESOURCE_DIR)' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_TARGET='$(PROCESSOR)-w64-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
        -DCOMPILER_RT_EXCLUDE_ATOMIC_BUILTIN=FALSE
    $(MAKE) -C '$(BUILD_DIR).compiler-rt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).compiler-rt' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))
endef

# libunwind / libcxxabi / libcxx
define $(PKG)_BUILD_RUNTIMES
    mkdir '$(BUILD_DIR).runtimes'
    cd '$(BUILD_DIR).runtimes' && $(TARGET)-cmake '$(SOURCE_DIR)/runtimes' \
        -DCMAKE_CXX_COMPILER_TARGET='$(PROCESSOR)-w64-windows-gnu' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_PATH='$(SOURCE_DIR)/llvm' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLLVM_ENABLE_RUNTIMES='libunwind;libcxxabi;libcxx' \
        -DLIBUNWIND_USE_COMPILER_RT=TRUE \
        -DLIBUNWIND_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBUNWIND_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBCXX_USE_COMPILER_RT=ON \
        -DLIBCXX_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBCXX_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE \
        -DLIBCXX_CXX_ABI=libcxxabi \
        -DLIBCXX_LIBDIR_SUFFIX='' \
        -DLIBCXX_INCLUDE_TESTS=FALSE \
        -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE \
        -DLIBCXXABI_USE_COMPILER_RT=ON \
        -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
        -DLIBCXXABI_ENABLE_SHARED=OFF \
        -DLIBCXXABI_LIBDIR_SUFFIX=''
    $(MAKE) -C '$(BUILD_DIR).runtimes' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).runtimes' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))
endef

define $(PKG)_BUILD
    $($(PKG)_BUILD_COMPILER_RT)
    $($(PKG)_BUILD_RUNTIMES)
endef
