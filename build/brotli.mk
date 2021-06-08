PKG             := brotli
$(PKG)_WEBSITE  := https://opensource.google.com/projects/brotli
$(PKG)_DESCR    := Brotli compression format
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.9
$(PKG)_CHECKSUM := f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46
$(PKG)_GH_CONF  := google/brotli/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DBROTLI_DISABLE_TESTS=ON \
        '$(SOURCE_DIR)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 $(subst -,/,$(INSTALL_STRIP_LIB))
endef
