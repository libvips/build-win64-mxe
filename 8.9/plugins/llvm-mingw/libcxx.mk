# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libcxx
$(PKG)_WEBSITE  := https://libcxx.llvm.org/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 10.0.0
$(PKG)_CHECKSUM := 270f8a3f176f1981b0f6ab8aa556720988872ec2b48ed3b605d0ced8d09156c7
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/libcxx-[0-9]*.patch)))
$(PKG)_GH_CONF  := llvm/llvm-project/releases,llvmorg-,,,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION).src
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).src.tar.xz
$(PKG)_DEPS     := llvm-mingw compiler-rt-builtins libunwind libcxxabi

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,libcxxabi,$(BUILD_DIR))

    mkdir '$(BUILD_DIR).libcxxabi'
    cd '$(BUILD_DIR).libcxxabi' && $(TARGET)-cmake '$(BUILD_DIR)/$(libcxxabi_SUBDIR)' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_COMPILER_CHECKED=TRUE \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLIBCXXABI_USE_COMPILER_RT=ON \
        -DLIBCXXABI_ENABLE_EXCEPTIONS=ON \
        -DLIBCXXABI_ENABLE_THREADS=ON \
        -DLIBCXXABI_TARGET_TRIPLE=$(TARGET) \
        -DLIBCXXABI_ENABLE_SHARED=OFF \
        -DLIBCXXABI_LIBCXX_INCLUDES='$(SOURCE_DIR)/include' \
        -DLIBCXXABI_LIBDIR_SUFFIX='' \
        -DLIBCXXABI_ENABLE_NEW_DELETE_DEFINITIONS=OFF \
        -DCXX_SUPPORTS_CXX_STD=TRUE \
        -DCMAKE_CXX_FLAGS='$(CXXFLAGS) $(if $(BUILD_SHARED),-D_LIBCPP_BUILDING_LIBRARY= -U_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS,-D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS) -D_LIBCPP_HAS_THREAD_API_WIN32'
    $(MAKE) -C '$(BUILD_DIR).libcxxabi' -j '$(JOBS)'

    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_CROSSCOMPILING=TRUE \
        -DCMAKE_C_COMPILER_WORKS=TRUE \
        -DCMAKE_CXX_COMPILER_WORKS=TRUE \
        -DLLVM_COMPILER_CHECKED=TRUE \
        -DCMAKE_AR='$(PREFIX)/$(BUILD)/bin/llvm-ar' \
        -DCMAKE_RANLIB='$(PREFIX)/$(BUILD)/bin/llvm-ranlib' \
        -DLIBCXX_USE_COMPILER_RT=ON \
        -DLIBCXX_INSTALL_HEADERS=ON \
        -DLIBCXX_ENABLE_EXCEPTIONS=ON \
        -DLIBCXX_ENABLE_THREADS=ON \
        -DLIBCXX_HAS_WIN32_THREAD_API=ON \
        -DLIBCXX_ENABLE_MONOTONIC_CLOCK=ON \
        -DLIBCXX_ENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DLIBCXX_ENABLE_STATIC=$(CMAKE_STATIC_BOOL) \
        -DLIBCXX_SUPPORTS_STD_EQ_CXX11_FLAG=TRUE \
        -DLIBCXX_HAVE_CXX_ATOMICS_WITHOUT_LIB=TRUE \
        -DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=OFF \
        -DLIBCXX_ENABLE_FILESYSTEM=OFF \
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE \
        -DLIBCXX_CXX_ABI=libcxxabi \
        -DLIBCXX_CXX_ABI_INCLUDE_PATHS='$(BUILD_DIR)/$(libcxxabi_SUBDIR)/include' \
        -DLIBCXX_CXX_ABI_LIBRARY_PATH='$(BUILD_DIR).libcxxabi/lib' \
        -DLIBCXX_LIBDIR_SUFFIX='' \
        -DLIBCXX_INCLUDE_TESTS=FALSE \
        -DCMAKE_CXX_FLAGS='$(CXXFLAGS) $(if $(BUILD_SHARED),-D_LIBCXXABI_BUILDING_LIBRARY,-D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS)' \
        -DCMAKE_SHARED_LINKER_FLAGS='-lunwind' \
        -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install/strip

    $(if $(BUILD_STATIC), \
        $(TARGET)-ar qcsL \
            '$(PREFIX)/$(TARGET)/lib/libc++.a' \
            '$(PREFIX)/$(TARGET)/lib/libunwind.a' \
    $(else), \
        $(TARGET)-ar qcsL \
            '$(PREFIX)/$(TARGET)/lib/libc++.dll.a' \
            '$(PREFIX)/$(TARGET)/lib/libunwind.dll.a')
endef
