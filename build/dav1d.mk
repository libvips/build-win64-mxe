PKG             := dav1d
$(PKG)_WEBSITE  := https://code.videolan.org/videolan/dav1d
$(PKG)_DESCR    := dav1d is a AV1 cross-platform decoder, open-source, and focused on speed and correctness
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.8.2
$(PKG)_CHECKSUM := 00438cf4abb45a56f3dff4c0ff76f4714540672118fe84eea24617d5ed2e394c
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://code.videolan.org/videolan/$(PKG)/-/archive/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc $(BUILD)~nasm

define $(PKG)_BUILD
    '$(TARGET)-meson' \
        --buildtype=release \
        --strip \
        --libdir='lib' \
        --includedir='include' \
        -Denable_tools=false \
        -Denable_examples=false \
        -Denable_tests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    ninja -C '$(BUILD_DIR)' install
endef
