PKG             := mingw-std-threads
$(PKG)_WEBSITE  := https://github.com/meganz/mingw-std-threads
$(PKG)_DESCR    := Standard threads implementation currently still missing on MinGW GCC on Windows
$(PKG)_IGNORE   :=
# https://github.com/meganz/mingw-std-threads/tarball/f6365f900fb9b1cd6014c8d1cf13ceacf8faf3de
$(PKG)_VERSION  := f6365f9
$(PKG)_CHECKSUM := 94046bb1d97ed8e15819dfae3460080c20e0bc851ae00caad104a3c00c93a0e4
$(PKG)_GH_CONF  := meganz/mingw-std-threads/branches/master
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    $(if $(WIN32_THREADS), \
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/$(PKG)'; \
        $(INSTALL) -m644 '$(SOURCE_DIR)/'*.h '$(PREFIX)/$(TARGET)/include/$(PKG)')
endef
