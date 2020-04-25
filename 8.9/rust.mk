PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.43.0
$(PKG)_CHECKSUM := 069f34fa5cef92551724c83c36360df1ac66fe3942bc1d0e4d341ce79611a029
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu.tar.gz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := $(foreach TARGET,$(MXE_TARGETS),rust-std-$(firstword $(call split,-,$(TARGET))))

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,rust-std-$(PROCESSOR),$(BUILD_DIR))
    mv '$(BUILD_DIR)/$(rust-std-$(PROCESSOR)_SUBDIR)' '$(SOURCE_DIR)'
    echo 'rust-std-$(PROCESSOR)-pc-windows-gnu' >> '$(SOURCE_DIR)/components'

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/install.sh \
        --prefix='$(PREFIX)/$(TARGET)' \
        --components='rustc,cargo,rust-std-x86_64-unknown-linux-gnu,rust-std-$(PROCESSOR)-pc-windows-gnu'
 
    # install prefixed wrappers
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/.cargo'
    (echo '#!/usr/bin/env bash'; \
     echo 'CARGO_HOME="$(PREFIX)/$(TARGET)/.cargo" \'; \
     echo 'RUSTC="$(PREFIX)/bin/$(TARGET)-rustc" \'; \
     echo 'exec $(PREFIX)/$(TARGET)/bin/cargo \'; \
     echo '"$$@"';) \
             > '$(PREFIX)/bin/$(TARGET)-cargo'
    chmod 0755 '$(PREFIX)/bin/$(TARGET)-cargo'

    ln -sf '$(PREFIX)/$(TARGET)/bin/rustc' '$(PREFIX)/bin/$(TARGET)-rustc'

    # Prefer the {,dll}crt2.o libraries from our
    # mingw-w64 to avoid any compatibility issues.
    $(foreach FILE, crt2.o dllcrt2.o, \
        cp -f '$(PREFIX)/$(TARGET)/lib/$(FILE)' '$(PREFIX)/$(TARGET)/lib/rustlib/$(PROCESSOR)-pc-windows-gnu/lib';)
endef
