PKG             := mingw-std-threads
$(PKG)_WEBSITE  := https://github.com/meganz/mingw-std-threads
$(PKG)_DESCR    := Standard threads implementation currently still missing on MinGW GCC on Windows
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 4e22f33
$(PKG)_CHECKSUM := 92c051b9e5017ecbe85e0004677315f5a2784bca9f61db17655321788fe2594a
$(PKG)_GH_CONF  := meganz/mingw-std-threads/branches/master
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/$(PKG)'
    $(INSTALL) -m644 '$(SOURCE_DIR)/'*.h '$(PREFIX)/$(TARGET)/include/$(PKG)'
endef
