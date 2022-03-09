PKG             := mingw-std-threads
$(PKG)_WEBSITE  := https://github.com/meganz/mingw-std-threads
$(PKG)_DESCR    := Standard threads implementation currently still missing on MinGW GCC on Windows
$(PKG)_IGNORE   :=
# https://github.com/meganz/mingw-std-threads/tarball/7e2507915900f5589febf0d8972cd5c9c03191f2
$(PKG)_VERSION  := 7e25079
$(PKG)_CHECKSUM := 0cee619c4458af543bb5da73779a4d493c5cbd7e1091f85f4a2f171c192030de
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := meganz/mingw-std-threads/branches/master
$(PKG)_DEPS     :=

define $(PKG)_BUILD
    $(if $(WIN32_THREADS), \
        $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/$(PKG)'; \
        $(INSTALL) -m644 '$(SOURCE_DIR)/'*.h '$(PREFIX)/$(TARGET)/include/$(PKG)')
endef
