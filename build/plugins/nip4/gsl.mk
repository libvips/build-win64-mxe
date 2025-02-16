PKG             := gsl
$(PKG)_WEBSITE  := https://www.gnu.org/software/gsl
$(PKG)_DESCR    := GNU scientific library
$(PKG)_IGNORE   :=
# https://ftp.snt.utwente.nl/pub/software/gnu/gsl/gsl-2.8.tar.gz",
$(PKG)_VERSION  := 2.8
$(PKG)_CHECKSUM := 6a99eeed15632c6354895b1dd542ed5a855c0f15d9ad1326c6fe2b2c9e423190
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://ftp.snt.utwente.nl/pub/software/gnu/$(PKG)/$(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_DEPS     := cc 

define $(PKG)_BUILD
    $(AUTOTOOLS_BUILD)
endef
