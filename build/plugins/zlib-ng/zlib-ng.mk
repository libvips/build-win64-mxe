PKG             := zlib-ng
$(PKG)_WEBSITE  := https://github.com/zlib-ng/zlib-ng
$(PKG)_DESCR    := zlib replacement with optimizations for "next generation" systems.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.1.7
$(PKG)_CHECKSUM := 59e68f67cbb16999842daeb517cdd86fc25b177b4affd335cd72b76ddc2a46d8
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := zlib-ng/zlib-ng/tags
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(eval export CFLAGS += -O3)

    cd '$(BUILD_DIR)' && '$(TARGET)-cmake' \
        -DZLIB_COMPAT=ON \
        -DZLIB_ENABLE_TESTS=OFF \
        '$(SOURCE_DIR)'

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
