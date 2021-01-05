PKG             := dav1d
$(PKG)_WEBSITE  := https://code.videolan.org/videolan/dav1d
$(PKG)_DESCR    := dav1d is a AV1 cross-platform decoder, open-source, and focused on speed and correctness
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.9.0
$(PKG)_CHECKSUM := ad6b89340f6e1a5c0c043763c0e28bb42d8930426f7dec049a8bc5e70076dd1a
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://code.videolan.org/videolan/$(PKG)/-/archive/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc $(BUILD)~nasm

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        -Denable_tools=false \
        -Denable_examples=false \
        -Denable_tests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
