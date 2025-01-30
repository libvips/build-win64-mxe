# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := llvm-mingw
$(PKG)_WEBSITE  := https://github.com/mstorsjo/llvm-mingw
$(PKG)_DESCR    := An LLVM/Clang/LLD based mingw-w64 toolchain
$(PKG)_TYPE     := meta

define $(PKG)_BUILD
    # install the usual wrappers
    $($(PKG)_PRE_BUILD)

    cp -Lrf '/opt/llvm-mingw/$(PROCESSOR)-w64-mingw32' '$(PREFIX)/$(TARGET)'

    # OpenMP, pthreads and winpthreads is not needed
    rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/bin/libomp.dll'
    rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/libomp.dll.a'
    rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/bin/libwinpthread-1.dll'
    rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/libwinpthread.'{dll.a,a,la}
    rm -f '$(PREFIX)/$(TARGET)/$(PROCESSOR)-w64-mingw32/lib/libpthread.'{dll.a,a}
endef

define $(PKG)_PRE_BUILD
    # setup target wrappers
    $(foreach EXEC, addr2line ar dlltool nm objcopy ranlib strings strip, \
        ln -sf '$(PREFIX)/$(BUILD)/bin/llvm-$(EXEC)' '$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-$(EXEC)'; \
        (echo '#!/bin/sh'; \
         echo 'exec "$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-$(EXEC)" "$$@"') \
                 > '$(PREFIX)/bin/$(TARGET)-$(EXEC)'; \
        chmod 0755 '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    # https://github.com/llvm/llvm-project/issues/64927
    ln -sf '$(PREFIX)/$(BUILD)/bin/llvm-windres' '$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-windres'
    (echo '#!/bin/sh'; \
     echo 'exec "$(PREFIX)/$(TARGET)/bin/$(PROCESSOR)-w64-mingw32-windres" \
         --preprocessor-arg="--sysroot=$(PREFIX)/$(TARGET)" "$$@"') \
             > '$(PREFIX)/bin/$(TARGET)-windres'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-windres'

    $(foreach EXEC, clang-target ld objdump, \
        $(INSTALL) -m755 '/opt/llvm-mingw/bin/$(EXEC)-wrapper.sh' '$(PREFIX)/$(TARGET)/bin'; \
        $(SED) -i -e 's|^DEFAULT_TARGET=.*|DEFAULT_TARGET=$(PROCESSOR)-w64-mingw32|' \
                  -e 's|^DIR=.*|DIR="$(PREFIX)/$(BUILD)/bin"|' \
                  -e 's|$$FLAGS "$$@"|$$FLAGS --sysroot="$(PREFIX)/$(TARGET)" "$$@"|' '$(PREFIX)/$(TARGET)/bin/$(EXEC)-wrapper.sh';)

    $(foreach EXEC, clang clang++ gcc g++ c++, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/clang-target-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)

    $(foreach EXEC, ld objdump, \
        ln -sf '$(PREFIX)/$(TARGET)/bin/$(EXEC)-wrapper.sh' '$(PREFIX)/bin/$(TARGET)-$(EXEC)';)
endef
