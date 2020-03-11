$(PLUGIN_HEADER)

# Override sub-dependencies
cc_DEPS := llvm-mingw libcxx

# Update MinGW-w64 to c4617ba
# https://github.com/mirror/mingw-w64/commit/b5706f8b6d9ff7890b8d6f3a4cc7443d8803ba85
# this includes https://sourceforge.net/p/mingw-w64/mailman/message/36942812/
mingw-w64_VERSION  := c4617ba
mingw-w64_CHECKSUM := 657cff71f43d4b65ae4bc5962b0456c2f0226f40dbb22feb226fafb151f9f3e9
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
