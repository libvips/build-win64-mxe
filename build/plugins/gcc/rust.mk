PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.72.1-x86_64-unknown-linux-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.72.1
$(PKG)_CHECKSUM := 5b5fa378b428aae010b1f1201a44d4aac83899216d3392aa0b2953edee633ba0
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
             > '$(PREFIX)/$(TARGET)/.cargo/config.toml'

    # Prefer the {,dll}crt2.o libraries from our
    # mingw-w64 to avoid any compatibility issues.
    $(foreach FILE, crt2.o dllcrt2.o, \
        cp -f '$(PREFIX)/$(TARGET)/mingw/lib/$(FILE)' '$(PREFIX)/$(TARGET)/lib/rustlib/$(PROCESSOR)-pc-windows-gnu/lib';)
endef
