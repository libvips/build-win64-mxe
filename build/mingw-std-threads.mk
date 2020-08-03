PKG             := mingw-std-threads
$(PKG)_WEBSITE  := https://github.com/meganz/mingw-std-threads
$(PKG)_DESCR    := Standard threads implementation currently still missing on MinGW GCC on Windows
$(PKG)_IGNORE   :=
# https://github.com/meganz/mingw-std-threads/tarball/bee085c0a6cb32c59f0b55c7bba976fe6dcfca7f
$(PKG)_VERSION  := bee085c
$(PKG)_CHECKSUM := eaa451e3db0b64b285ae2bc163e30f384ee933bb2765ed428b95686a94814dd7
$(PKG)_GH_CONF  := meganz/mingw-std-threads/branches/master
$(PKG)_DEPS     :=


define $(PKG)_BUILD
    $(if $(WIN32_THREADS),\
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/$(PKG)'; \
        $(INSTALL) -m644 '$(SOURCE_DIR)/'*.h '$(PREFIX)/$(TARGET)/include/$(PKG)')
endef
