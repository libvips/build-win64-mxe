# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_VERSION  := 12.0.0
$(PKG)_DEPS     := cc
$(PKG)_TYPE     := meta

# Note: Ubsan includes <typeinfo> from the C++ headers, so
# this has to be built after libcxx.
define $(PKG)_BUILD
    # i686 -> i386
    $(eval BUILD_ARCH_NAME := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    $(call PREPARE_PKG_SOURCE,llvm,$(SOURCE_DIR))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)/$(llvm_SUBDIR)/compiler-rt' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DCMAKE_C_COMPILER_TARGET='$(BUILD_ARCH_NAME)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
        -DCOMPILER_RT_BUILD_BUILTINS=FALSE \
        -DCOMPILER_RT_BUILD_LIBFUZZER=FALSE \
        -DCOMPILER_RT_BUILD_PROFILE=FALSE \
        -DCOMPILER_RT_BUILD_MEMPROF=FALSE \
        -DSANITIZER_CXX_ABI=libc++
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' install-compiler-rt-headers -j 1

    $(INSTALL) -d '$(PREFIX)/$(BUILD)/lib/clang/$(clang_VERSION)/lib/windows'

    find '$(BUILD_DIR)/lib/windows' -name 'libclang_rt.*.a' \
        -exec $(INSTALL) -m644 {} '$(PREFIX)/$(BUILD)/lib/clang/$(clang_VERSION)/lib/windows' \;

    find '$(BUILD_DIR)/lib/windows' -type f -name 'libclang_rt.*.dll' \
        -exec $(INSTALL) -m644 {} '$(PREFIX)/$(TARGET)/bin' \;
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_armv7-w64-mingw32   =
$(PKG)_BUILD_aarch64-w64-mingw32 =
