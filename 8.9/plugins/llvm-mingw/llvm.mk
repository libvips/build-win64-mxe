# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm
$(PKG)_WEBSITE  := https://llvm.org/
$(PKG)_DESCR    := A collection of modular and reusable compiler and toolchain technologies
$(PKG)_IGNORE   :=
# This version needs to be in-sync with the clang, lld, compiler-rt, libunwind, libcxx and libcxxabi packages
$(PKG)_VERSION  := 9.0.1
$(PKG)_CHECKSUM := 00a1ee1f389f81e9979f3a640a01c431b3021de0d42278f6508391a2f0b81c9a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/llvm-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
# This is needed to properly override: https://github.com/mxe/mxe/blob/master/src/llvm.mk#L11
$(PKG)_URL      := https://github.com/llvm/llvm-project/releases/download/llvmorg-$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := $(BUILD)~cmake clang lld

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,clang,$(BUILD_DIR))
    $(call PREPARE_PKG_SOURCE,lld,$(BUILD_DIR))

    cd '$(BUILD_DIR)' && cmake '$(SOURCE_DIR)' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_ENABLE_ASSERTIONS=OFF \
        -DLLVM_TARGETS_TO_BUILD=$(strip \
            $(if $(findstring armv7,$(PROCESSOR)),ARM, \
            $(if $(findstring aarch64,$(PROCESSOR)),AArch64, \
            X86))) \
        -DLLVM_TARGET_ARCH='$(PROCESSOR)' \
        -DLLVM_DEFAULT_TARGET_TRIPLE='$(TARGET)' \
        -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON \
        -DLLVM_TOOLCHAIN_TOOLS='llvm-ar;llvm-ranlib;llvm-objdump;llvm-rc;llvm-cvtres;llvm-nm;llvm-strings;llvm-readobj;llvm-dlltool;llvm-pdbutil;llvm-objcopy;llvm-strip;llvm-cov;llvm-profdata;llvm-addr2line;llvm-symbolizer' \
        -DLLVM_EXTERNAL_CLANG_SOURCE_DIR='$(BUILD_DIR)/$(clang_SUBDIR)' \
        -DLLVM_EXTERNAL_LLD_SOURCE_DIR='$(BUILD_DIR)/$(lld_SUBDIR)' \
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
        -DLLVM_INCLUDE_UTILS=OFF
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install/strip
endef
