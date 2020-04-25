# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-builtins
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_VERSION  := 10.0.0
$(PKG)_DEPS     := llvm-mingw compiler-rt
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    # armv7 -> arm
    $(eval LIB_ARCH_NAME := $(if $(findstring armv7,$(PROCESSOR)),arm,$(BUILD_ARCH_NAME)))

    $(call PREPARE_PKG_SOURCE,compiler-rt,$(BUILD_DIR))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(BUILD_DIR)/$(compiler-rt_SUBDIR)/lib/builtins' \
        -DCMAKE_AR='$(PREFIX)/$(TARGET)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(TARGET)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(BUILD_ARCH_NAME)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'

    $(INSTALL) -d '$(PREFIX)/$(TARGET)/lib/clang/$($(PKG)_VERSION)/lib/windows'
    cp '$(BUILD_DIR)/lib/windows/libclang_rt.builtins-$(BUILD_ARCH_NAME).a' \
        '$(PREFIX)/$(TARGET)/lib/clang/$($(PKG)_VERSION)/lib/windows/libclang_rt.builtins-$(LIB_ARCH_NAME).a'
endef
