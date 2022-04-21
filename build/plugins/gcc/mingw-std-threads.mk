PKG             := mingw-std-threads
$(PKG)_WEBSITE  := https://github.com/meganz/mingw-std-threads
$(PKG)_DESCR    := Standard threads implementation currently still missing on MinGW GCC on Windows
$(PKG)_IGNORE   :=
# https://github.com/meganz/mingw-std-threads/tarball/6c2061b7da41d6aa1b2162ff4383ec3ece864bc6
$(PKG)_VERSION  := 6c2061b
$(PKG)_CHECKSUM := 97f7fd95006ca13c81ab8b9bc7b8a22b55b8cc83c24a9ac21423c7c3840a46bd
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := meganz/mingw-std-threads/branches/master
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    $(if $(WIN32_THREADS), \
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/$(PKG)'; \
        $(INSTALL) -m644 '$(SOURCE_DIR)/'*.h '$(PREFIX)/$(TARGET)/include/$(PKG)')
endef
