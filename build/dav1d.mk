PKG             := dav1d
$(PKG)_WEBSITE  := https://code.videolan.org/videolan/dav1d
$(PKG)_DESCR    := dav1d is a AV1 cross-platform decoder, open-source, and focused on speed and correctness
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.5.1
$(PKG)_CHECKSUM := 401813f1f89fa8fd4295805aa5284d9aed9bc7fc1fdbe554af4292f64cbabe21
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://downloads.videolan.org/pub/videolan/$(PKG)/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper $(BUILD)~nasm

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        -Denable_tools=false \
        -Denable_examples=false \
        -Denable_tests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
