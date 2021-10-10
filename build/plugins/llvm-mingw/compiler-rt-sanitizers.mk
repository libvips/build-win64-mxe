# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := compiler-rt-sanitizers
$(PKG)_WEBSITE  := https://compiler-rt.llvm.org/
$(PKG)_VERSION  := 13.0.0
$(PKG)_DEPS     := cc
$(PKG)_TYPE     := meta

# Note: Ubsan includes <typeinfo> from the C++ headers, so
# this has to be built after libcxx.
define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,llvm,$(SOURCE_DIR))

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)/$(llvm_SUBDIR)/compiler-rt' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)/lib/clang/$(clang_VERSION)' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_TARGET='$(PROCESSOR)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
        -DCOMPILER_RT_BUILD_BUILTINS=FALSE \
        -DCOMPILER_RT_BUILD_LIBFUZZER=FALSE \
        -DCOMPILER_RT_BUILD_PROFILE=FALSE \
        -DCOMPILER_RT_BUILD_MEMPROF=FALSE \
        -DSANITIZER_CXX_ABI=libc++ \
        $(if $(BUILD_STATIC), -DCMAKE_REQUIRED_LIBRARIES='unwind')
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))

    mv -v '$(PREFIX)/$(BUILD)/lib/clang/$(clang_VERSION)/lib/windows/'*.dll '$(PREFIX)/$(TARGET)/bin/'
endef

# Sanitizers on windows only support x86.
$(PKG)_BUILD_armv7-w64-mingw32   =
$(PKG)_BUILD_aarch64-w64-mingw32 =
