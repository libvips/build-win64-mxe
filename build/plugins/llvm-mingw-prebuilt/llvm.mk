# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm
$(PKG)_WEBSITE  := https://llvm.org/
$(PKG)_DESCR    := A collection of modular and reusable compiler and toolchain technologies
$(PKG)_TYPE     := meta
$(PKG)_DEPS     := $(BUILD)~$(PKG) llvm-mingw
# This is needed to properly override: https://github.com/mxe/mxe/blob/master/src/llvm.mk#L8-L11
$(PKG)_GH_CONF  :=
$(PKG)_SUBDIR   :=
$(PKG)_FILE     :=
$(PKG)_URL      :=

define $(PKG)_BUILD_$(BUILD)
    $(foreach EXEC, clang ld.lld, \
        ln -sf '/opt/llvm-mingw/bin/$(EXEC)' '$(PREFIX)/$(BUILD)/bin/$(EXEC)';)

    $(foreach EXEC, ar ranlib objdump rc cvtres nm strings readobj dlltool pdbutil objcopy strip cov profdata addr2line symbolizer windres, \
        ln -sf '/opt/llvm-mingw/bin/llvm-$(EXEC)' '$(PREFIX)/$(BUILD)/bin/llvm-$(EXEC)';)
endef

define $(PKG)_BUILD_STATIC
   # Ensure we statically link against libunwind and libc++
   $(foreach LIB, c++ unwind, \
        rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/bin/lib$(LIB).dll'; \
        rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/lib$(LIB).dll.a';)
endef

$(PKG)_BUILD_SHARED =
