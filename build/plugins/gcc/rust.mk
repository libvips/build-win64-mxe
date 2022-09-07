PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.63.0-x86_64-unknown-linux-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.63.0
$(PKG)_CHECKSUM := be9b25bcf1e564876762e653688e0b5df11fab53048ac18bf77761cf0a0cc465
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := $(foreach TARGET,$(MXE_TARGETS),rust-std-$(firstword $(call split,-,$(TARGET))))

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,rust-std-$(PROCESSOR),$(BUILD_DIR))
    mv '$(BUILD_DIR)/$(rust-std-$(PROCESSOR)_SUBDIR)' '$(SOURCE_DIR)'
    echo 'rust-std-$(PROCESSOR)-pc-windows-gnu' >> '$(SOURCE_DIR)/components'

    # Install in $(PREFIX)/$(TARGET) to avoid conflicts
    # with the llvm-mingw plugin.
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
endef
