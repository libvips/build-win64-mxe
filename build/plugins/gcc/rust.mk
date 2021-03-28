PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.50.0-x86_64-unknown-linux-gnu.tar.gz.sha256
$(PKG)_VERSION  := 1.50.0
$(PKG)_CHECKSUM := fa889b53918980aea2dea42bfae4e858dcb2104c6fdca6e4fe359f3a49767701
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu.tar.gz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := $(foreach TARGET,$(MXE_TARGETS),rust-std-$(firstword $(call split,-,$(TARGET))))

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,rust-std-$(PROCESSOR),$(BUILD_DIR))
    mv '$(BUILD_DIR)/$(rust-std-$(PROCESSOR)_SUBDIR)' '$(SOURCE_DIR)'
    echo 'rust-std-$(PROCESSOR)-pc-windows-gnu' >> '$(SOURCE_DIR)/components'

    # Install in $(PREFIX)/$(TARGET) to avoid conflicts
    # with the llvm-mingw plugin.
    # TODO(kleisauke): Could be installed in $(PREFIX)/$(BUILD)
    # if we build all binaries with LLVM.
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/install.sh \
        --prefix='$(PREFIX)/$(TARGET)' \
        --components='rustc,cargo,rust-std-x86_64-unknown-linux-gnu,rust-std-$(PROCESSOR)-pc-windows-gnu'

    # Install Cargo config
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/.cargo'
    (echo '[build]'; \
     echo 'target = "$(PROCESSOR)-pc-windows-gnu"'; \
     echo '[target.$(PROCESSOR)-pc-windows-gnu]'; \
     echo 'linker = "$(TARGET)-gcc"'; \
     echo 'ar = "$(TARGET)-ar"';) \
             > '$(PREFIX)/$(TARGET)/.cargo/config'

    # Install prefixed wrappers
    (echo '#!/usr/bin/env bash'; \
     echo 'CARGO_HOME="$(PREFIX)/$(TARGET)/.cargo" \'; \
     echo 'RUSTC="$(PREFIX)/$(TARGET)/bin/rustc" \'; \
     echo 'exec $(PREFIX)/$(TARGET)/bin/cargo \'; \
     echo '"$$@"';) \
             > '$(PREFIX)/bin/$(TARGET)-cargo'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-cargo'

    ln -sf '$(PREFIX)/$(TARGET)/bin/rustc' '$(PREFIX)/bin/$(TARGET)-rustc'

    # Prefer the {,dll}crt2.o libraries from our
    # mingw-w64 to avoid any compatibility issues.
    $(foreach FILE, crt2.o dllcrt2.o, \
        cp -f '$(PREFIX)/$(TARGET)/mingw/lib/$(FILE)' '$(PREFIX)/$(TARGET)/lib/rustlib/$(PROCESSOR)-pc-windows-gnu/lib';)

    # Create dummy libpthread.a as Rust links against this library by default:
    # https://github.com/rust-lang/rust/blob/76aca6659a0eb3f5696541d0be518530cabdd963/compiler/rustc_target/src/spec/windows_gnu_base.rs#L59
    # This could also be fixed when using POSIX threads functionality in GCC
    # but that is significantly slower than the native Win32 implementation.
    $(if $(BUILD_SHARED),
        echo 'static int __attribute__((unused)) _dummy;' > '$(BUILD_DIR)/dummy.c'
        $(TARGET)-gcc -c -o '$(BUILD_DIR)/dummy.o' '$(BUILD_DIR)/dummy.c'
        $(TARGET)-ar rcs '$(PREFIX)/$(TARGET)/lib/rustlib/$(PROCESSOR)-pc-windows-gnu/lib/libpthread.a' '$(BUILD_DIR)/dummy.o'
    )
endef
