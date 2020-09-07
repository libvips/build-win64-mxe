# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_VERSION  := 11.0.0-rc2
$(PKG)_DEPS     := compiler-rt
$(PKG)_TYPE     := meta

# Note: Ubsan includes <typeinfo> from the C++ headers, so
# this has to be built after libcxx.
define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    # [major].[minor].[patch]-[label] -> [major].[minor].[patch]
    $(eval CLANG_VERSION := $(firstword $(subst -, ,$($(PKG)_VERSION))))

    $(call PREPARE_PKG_SOURCE,compiler-rt,$(BUILD_DIR))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(BUILD_DIR)/$(compiler-rt_SUBDIR)' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(BUILD_ARCH_NAME)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' install-compiler-rt-headers -j 1

    $(INSTALL) -d '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows'

    $(foreach FILE,asan-preinit asan asan_cxx asan_dll_thunk asan_dynamic_runtime_thunk ubsan_standalone ubsan_standalone_cxx, \
        cp '$(BUILD_DIR)/lib/windows/libclang_rt.$(FILE)-$(BUILD_ARCH_NAME).a' '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows';)

    cp '$(BUILD_DIR)/lib/windows/libclang_rt.asan_dynamic-$(BUILD_ARCH_NAME).dll.a' '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows'
    cp '$(BUILD_DIR)/lib/windows/libclang_rt.asan_dynamic-$(BUILD_ARCH_NAME).dll' '$(PREFIX)/$(TARGET)/bin'
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_armv7-w64-mingw32   =
$(PKG)_BUILD_aarch64-w64-mingw32 =
