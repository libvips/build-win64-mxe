# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := test-llvm-mingw
$(PKG)_WEBSITE  := https://github.com/mstorsjo/llvm-mingw/tree/master/test
$(PKG)_DESCR    := Tests for llvm-mingw
$(PKG)_VERSION  := 1
$(PKG)_DEPS     := cc compiler-rt-sanitizers widl
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    $(eval TEST_DIR := $(PREFIX)/$(TARGET)/bin/$(PKG))

    $(call PREPARE_PKG_SOURCE,llvm-mingw,$(BUILD_DIR))

    $(INSTALL) -d '$(TEST_DIR)'

    # Sanitizers on Windows only support x86
    # Disable static linkage tests, if needed
    cd '$(TEST_DIR)' && $(MAKE) -f '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/Makefile' -j '$(JOBS)' all \
        ARCH=$(PROCESSOR) \
        CROSS=$(TARGET)- \
        HAVE_UWP= \
        HAVE_OPENMP= \
        HAVE_CFGUARD= \
        $(if $(IS_X86), HAVE_ASAN=1) \
        $(if $(BUILD_SHARED), TESTS_CPP_STATIC=) \
        RUNTIMES_SRC='$(PREFIX)/$(TARGET)/bin' \
        NATIVE= \
        RUN=

    # Bundle tests
    cd '$(PREFIX)/$(TARGET)/bin' && 7za a -tzip $(PKG).zip $(PKG)
endef
