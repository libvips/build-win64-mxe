PKG             := rust
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.84.0-x86_64-unknown-linux-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.84.0
$(PKG)_CHECKSUM := 73aca7e08720b7bf28beee8f2370c6aef961aa87e9674989f5ce62ec2f95dcfd
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION)-x86_64-unknown-linux-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := $(BUILD)~$(PKG) $(foreach TARGET,$(MXE_TARGETS),rust-std-$(firstword $(call split,-,$(TARGET))))
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)
$(PKG)_DEPS_$(BUILD) :=

define $(PKG)_BUILD_$(BUILD)
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/install.sh \
        --prefix='$(PREFIX)/$(BUILD)' \
        --components='rustc,cargo,rust-std-x86_64-unknown-linux-gnu'
endef

define $(PKG)_BUILD
    $(call PREPARE_PKG_SOURCE,rust-std-$(PROCESSOR),$(BUILD_DIR))
    mv '$(BUILD_DIR)/$(rust-std-$(PROCESSOR)_SUBDIR)' '$(SOURCE_DIR)'
    echo 'rust-std-$(PROCESSOR)-pc-windows-gnu' >> '$(SOURCE_DIR)/components'

    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/install.sh \
        --prefix='$(PREFIX)/$(BUILD)' \
        --components='rust-std-$(PROCESSOR)-pc-windows-gnu'

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
        cp -f '$(PREFIX)/$(TARGET)/mingw/lib/$(FILE)' '$(PREFIX)/$(BUILD)/lib/rustlib/$(PROCESSOR)-pc-windows-gnu/lib';)

    # Create empty dummy archive for libpthread.a, to avoid failing when
    # Rust will link with "-l:libpthread.a".
    # https://github.com/rust-lang/rust/blob/1.84.0/compiler/rustc_target/src/spec/base/windows_gnu.rs#L63
    $(TARGET)-ar rcs '$(PREFIX)/$(TARGET)/mingw/lib/libpthread.a'
endef
