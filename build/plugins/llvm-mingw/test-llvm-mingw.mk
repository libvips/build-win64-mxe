# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := test-llvm-mingw
$(PKG)_WEBSITE  := https://github.com/mstorsjo/llvm-mingw/tree/master/test
$(PKG)_DESCR    := Tests for llvm-mingw
$(PKG)_VERSION  := 1
$(PKG)_DEPS     := cc compiler-rt-sanitizers
$(PKG)_TYPE     := meta

$(PKG)_TESTS_C              := hello hello-tls crt-test setjmp
$(PKG)_TESTS_C_DLL          := autoimport-lib
$(PKG)_TESTS_C_LINK_DLL     := autoimport-main
$(PKG)_TESTS_C_NO_BUILTIN   := crt-test
$(PKG)_TESTS_C_ANSI_STDIO   := crt-test
$(PKG)_TESTS_CPP            := hello-cpp global-terminate longjmp-cleanup
$(PKG)_TESTS_CPP_LOAD_DLL   := tlstest-main
$(PKG)_TESTS_CPP_EXCEPTIONS := hello-exception exception-locale exception-reduced
$(PKG)_TESTS_CPP_DLL        := tlstest-lib throwcatch-lib
$(PKG)_TESTS_CPP_LINK_DLL   := throwcatch-main
$(PKG)_TESTS_SSP            := stacksmash
$(PKG)_TESTS_ASAN           := stacksmash
$(PKG)_TESTS_UBSAN          := ubsan

define $(PKG)_BUILD
    # i686 -> i386
    $(eval COMPILER_RT_ARCH := $(if $(findstring i686,$(PROCESSOR)),i386,$(PROCESSOR)))

    $(eval TEST_DIR := $(PREFIX)/$(TARGET)/bin/$(PKG))

    $(call PREPARE_PKG_SOURCE,llvm-mingw,$(BUILD_DIR))

    $(INSTALL) -d '$(TEST_DIR)'
    $(foreach TEST, $($(PKG)_TESTS_C), \
        '$(TARGET)-clang' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST).exe';)

    $(foreach TEST, $($(PKG)_TESTS_C_DLL), \
        '$(TARGET)-clang' -shared \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST).dll' \
            -Wl,--out-implib,'$(TEST_DIR)/lib$(TEST).dll.a';)

    $(foreach TEST, $($(PKG)_TESTS_C_LINK_DLL), \
        '$(TARGET)-clang' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST).exe' \
            -L'$(TEST_DIR)' -l$(subst -main,,$(TEST))-lib;)

    $(foreach TEST, $($(PKG)_TESTS_C_NO_BUILTIN), \
        '$(TARGET)-clang' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST)-no-builtin.exe' \
            -fno-builtin;)

    $(foreach TEST, $($(PKG)_TESTS_C_ANSI_STDIO), \
        '$(TARGET)-clang' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST)-ansi-stdio.exe' \
            -D__USE_MINGW_ANSI_STDIO=1;)

    $(foreach TEST, $($(PKG)_TESTS_CPP) $($(PKG)_TESTS_CPP_EXCEPTIONS) $($(PKG)_TESTS_CPP_LOAD_DLL), \
        '$(TARGET)-clang++' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).cpp' -o '$(TEST_DIR)/$(TEST).exe';)

    $(foreach TEST, $($(PKG)_TESTS_CPP_DLL), \
        '$(TARGET)-clang++' -shared \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).cpp' -o '$(TEST_DIR)/$(TEST).dll' \
            -Wl,--out-implib,'$(TEST_DIR)/lib$(TEST).dll.a';)

    $(foreach TEST, $($(PKG)_TESTS_CPP_LINK_DLL), \
        '$(TARGET)-clang++' \
            '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).cpp' -o '$(TEST_DIR)/$(TEST).exe' \
            -L'$(TEST_DIR)' -l$(subst -main,,$(TEST))-lib;)

    # We're not building libssp, so disable this test for now.
    # $(foreach TEST, $($(PKG)_TESTS_SSP), \
    #     '$(TARGET)-clang' \
    #         '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST).exe' \
    #         -fstack-protector-strong;)

    # Sanitizers on windows only support x86.
    # Ubsan might not require anything too x86 specific, but we don't
    # build any of the sanitizer libs for anything else than x86.
    $(if $(IS_X86),
        $(foreach TEST, $($(PKG)_TESTS_ASAN), \
            '$(TARGET)-clang' \
                '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST)-asan.exe' \
                -fsanitize=address -g -gcodeview -Wl,-pdb,'$(TEST_DIR)/$(TEST)-asan.pdb';)

        $(foreach TEST, $($(PKG)_TESTS_UBSAN), \
            '$(TARGET)-clang' \
                '$(BUILD_DIR)/$(llvm-mingw_SUBDIR)/test/$(TEST).c' -o '$(TEST_DIR)/$(TEST).exe' \
                -fsanitize=undefined;)
    )

    $(if $(BUILD_SHARED),
        # Copy needed dependencies to test directory
        $(foreach FILE, libc++ libunwind $(if $(IS_X86),libclang_rt.asan_dynamic-$(COMPILER_RT_ARCH),), \
            cp '$(PREFIX)/$(TARGET)/bin/$(FILE).dll' '$(TEST_DIR)';)
    )

    # Bundle tests
    cd '$(PREFIX)/$(TARGET)/bin' && 7za a -tzip $(PKG).zip $(PKG)
endef
