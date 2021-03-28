# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-builtins
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_VERSION  := 11.1.0
$(PKG)_DEPS     := compiler-rt
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    # armv7 -> arm
    $(eval LIB_ARCH_NAME := $(if $(findstring armv7,$(PROCESSOR)),arm,$(BUILD_ARCH_NAME)))

    # [major].[minor].[patch]-[label] -> [major].[minor].[patch]
    $(eval CLANG_VERSION := $(firstword $(subst -, ,$($(PKG)_VERSION))))

    $(call PREPARE_PKG_SOURCE,compiler-rt,$(BUILD_DIR))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(BUILD_DIR)/$(compiler-rt_SUBDIR)/lib/builtins' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(BUILD_ARCH_NAME)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
        -DLLVM_CONFIG_PATH:FILEPATH=''
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'

    $(INSTALL) -d '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows'
    cp '$(BUILD_DIR)/lib/windows/libclang_rt.builtins-$(BUILD_ARCH_NAME).a' \
        '$(PREFIX)/$(BUILD)/lib/clang/$(CLANG_VERSION)/lib/windows/libclang_rt.builtins-$(LIB_ARCH_NAME).a'
endef
