# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm
$(PKG)_WEBSITE  := https://llvm.org/
$(PKG)_DESCR    := A collection of modular and reusable compiler and toolchain technologies
$(PKG)_IGNORE   :=
# This version needs to be in-sync with the compiler-rt-sanitizers package
$(PKG)_VERSION  := 13.0.0-rc3
$(PKG)_CHECKSUM := e48d7ae488f56d1eedfb2dc10443376c230eb770704f508a8fa285a41549dca5
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/llvm-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases/latest,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-project-$(subst -,,$($(PKG)_VERSION)).src
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
        -DLLVM_TARGETS_TO_BUILD='ARM;AArch64;X86' \
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
        -DLLVM_INCLUDE_GO_TESTS=OFF \
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
    # i686 -> i386
    $(eval COMPILER_RT_ARCH := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    mkdir '$(BUILD_DIR).compiler-rt'
    cd '$(BUILD_DIR).compiler-rt' && $(TARGET)-cmake '$(SOURCE_DIR)/compiler-rt/lib/builtins' \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(BUILD)/lib/clang/$(clang_VERSION)' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DCMAKE_C_COMPILER_TARGET='$(COMPILER_RT_ARCH)-windows-gnu' \
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE \
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE
    $(MAKE) -C '$(BUILD_DIR).compiler-rt' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).compiler-rt' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))
endef

define $(PKG)_BUILD_LIBUNWIND
    mkdir '$(BUILD_DIR).libunwind'
    cd '$(BUILD_DIR).libunwind' && $(TARGET)-cmake '$(SOURCE_DIR)/libunwind' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_PATH='$(SOURCE_DIR)/llvm' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLIBUNWIND_USE_COMPILER_RT=TRUE \
        -DLIBUNWIND_ENABLE_THREADS=TRUE \
        -DLIBUNWIND_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBUNWIND_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBUNWIND_ENABLE_CROSS_UNWINDING=FALSE
    $(MAKE) -C '$(BUILD_DIR).libunwind' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).libunwind' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))
endef

define $(PKG)_BUILD_LIBCXX
    # Configure, but don't build, libcxx, so that libcxxabi has
    # proper headers to refer to
    mkdir '$(BUILD_DIR).libcxx'
    cd '$(BUILD_DIR).libcxx' && $(TARGET)-cmake '$(SOURCE_DIR)/libcxx' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_PATH='$(SOURCE_DIR)/llvm' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLIBCXX_USE_COMPILER_RT=ON \
        -DLIBCXX_INSTALL_HEADERS=ON \
        -DLIBCXX_ENABLE_EXCEPTIONS=ON \
        -DLIBCXX_ENABLE_THREADS=ON \
        -DLIBCXX_HAS_WIN32_THREAD_API=ON \
        -DLIBCXX_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBCXX_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=OFF \
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE \
        -DLIBCXX_ENABLE_NEW_DELETE_DEFINITIONS=OFF \
        -DLIBCXX_CXX_ABI=libcxxabi \
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS='$(SOURCE_DIR)/libcxxabi/include' \
        -DLIBCXX_CXX_ABI_LIBRARY_PATH='$(BUILD_DIR).libcxxabi/lib' \
        -DLIBCXX_LIBDIR_SUFFIX='' \
        -DLIBCXX_INCLUDE_TESTS=FALSE \
        -DCMAKE_SHARED_LINKER_FLAGS='-lunwind' \
        -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE
    $(MAKE) -C '$(BUILD_DIR).libcxx' -j '$(JOBS)' generate-cxx-headers

    mkdir '$(BUILD_DIR).libcxxabi'
    cd '$(BUILD_DIR).libcxxabi' && $(TARGET)-cmake '$(SOURCE_DIR)/libcxxabi' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_PATH='$(SOURCE_DIR)/llvm' \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLIBCXXABI_USE_COMPILER_RT=ON \
        -DLIBCXXABI_ENABLE_EXCEPTIONS=ON \
        -DLIBCXXABI_ENABLE_THREADS=ON \
        -DLIBCXXABI_ENABLE_SHARED=OFF \
        -DLIBCXXABI_LIBCXX_INCLUDES='$(BUILD_DIR).libcxx/include/c++/v1' \
        -DLIBCXXABI_LIBDIR_SUFFIX='' \
        -DLIBCXXABI_ENABLE_NEW_DELETE_DEFINITIONS=ON \
        -DLIBCXX_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE
    $(MAKE) -C '$(BUILD_DIR).libcxxabi' -j '$(JOBS)'

    $(MAKE) -C '$(BUILD_DIR).libcxx' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR).libcxx' -j 1 $(subst -,/,$(INSTALL_STRIP_TOOLCHAIN))

    $(if $(BUILD_STATIC), \
        $(TARGET)-ar qcsL \
            '$(PREFIX)/$(TARGET)/lib/libc++.a' \
            '$(PREFIX)/$(TARGET)/lib/libunwind.a' \
    $(else), \
        $(TARGET)-ar qcsL \
            '$(PREFIX)/$(TARGET)/lib/libc++.dll.a' \
            '$(PREFIX)/$(TARGET)/lib/libunwind.dll.a')
endef

define $(PKG)_BUILD
    $($(PKG)_BUILD_COMPILER_RT)
    $($(PKG)_BUILD_LIBUNWIND)
    $($(PKG)_BUILD_LIBCXX)
endef
