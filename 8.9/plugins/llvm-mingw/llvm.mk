# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm
$(PKG)_WEBSITE  := https://llvm.org/
$(PKG)_DESCR    := A collection of modular and reusable compiler and toolchain technologies
$(PKG)_IGNORE   :=
# This version needs to be in-sync with the clang, lld, lldb, compiler-rt, libunwind, libcxx and libcxxabi packages
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := df83a44b3a9a71029049ec101fb0077ecbbdf5fe41e395215025779099a98fdf
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/llvm-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases/latest,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_DEPS     := $(BUILD)~$(PKG)
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

$(PKG)_DEPS_$(BUILD) := cmake clang lld lldb

define $(PKG)_BUILD_$(BUILD)
    $(call PREPARE_PKG_SOURCE,clang,$(BUILD_DIR))
    $(call PREPARE_PKG_SOURCE,lld,$(BUILD_DIR))
    $(call PREPARE_PKG_SOURCE,lldb,$(BUILD_DIR))

    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_ASSERTIONS=OFF \
        -DLLVM_TARGETS_TO_BUILD='ARM;AArch64;X86' \
        -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
        -DLLVM_TOOLCHAIN_TOOLS='llvm-ar;llvm-ranlib;llvm-objdump;llvm-rc;llvm-cvtres;llvm-nm;llvm-strings;llvm-readobj;llvm-dlltool;llvm-pdbutil;llvm-objcopy;llvm-strip;llvm-cov;llvm-profdata;llvm-addr2line;llvm-symbolizer' \
        -DLLVM_EXTERNAL_CLANG_SOURCE_DIR='$(BUILD_DIR)/$(clang_SUBDIR)' \
        -DLLVM_EXTERNAL_LLD_SOURCE_DIR='$(BUILD_DIR)/$(lld_SUBDIR)' \
        -DLLVM_EXTERNAL_LLDB_SOURCE_DIR='$(BUILD_DIR)/$(lldb_SUBDIR)' \
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
        -DLLVM_INCLUDE_GO_TESTS=OFF \
        -DLLVM_INCLUDE_TESTS=OFF \
        -DLLVM_INCLUDE_UTILS=OFF \
        -DLLDB_ENABLE_LIBEDIT=OFF \
        -DLLDB_ENABLE_PYTHON=OFF \
        -DLLDB_ENABLE_CURSES=OFF \
        -DLLDB_ENABLE_LUA=OFF \
        -DLLDB_INCLUDE_TESTS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install/strip
endef

define $(PKG)_BUILD
    # setup symlinks
    $(foreach EXEC, clang clang++ ld.lld llvm-dlltool llvm-objdump, \
        ln -sf '$(PREFIX)/$(BUILD)/bin/$(EXEC)' '$(PREFIX)/$(TARGET)/bin/$(EXEC)';)

    # setup target wrappers
    # Can't symlink here, it will break the basename detection of LLVM. See:
    # sys::path::stem("x86_64-w64-mingw32.shared-ranlib"); -> x86_64-w64-mingw32
    # https://github.com/llvm/llvm-project/blob/9a432161c68774e6c717616e3d688142e89bbb42/llvm/tools/llvm-ar/llvm-ar.cpp#L1181-L1192
    $(foreach EXEC, addr2line ar cvtres nm objcopy ranlib rc strings strip, \
        (echo '#!/bin/sh'; \
         echo 'exec "$(PREFIX)/$(BUILD)/bin/llvm-$(EXEC)" "$$@"') \
                 > '$(PREFIX)/bin/$(TARGET)-$(EXEC)'; \
        chmod 0755 '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)
endef
