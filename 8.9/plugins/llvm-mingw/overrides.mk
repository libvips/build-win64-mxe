$(PLUGIN_HEADER)

# Override sub-dependencies
cc_DEPS  := llvm-mingw libcxx

# Update MinGW-w64 to 7.0.0
mingw-w64_VERSION  := 7.0.0
mingw-w64_CHECKSUM := aa20dfff3596f08a7f427aab74315a6cb80c2b086b4a107ed35af02f9496b628
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mingw-w64-v$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-v$(mingw-w64_VERSION).tar.bz2
mingw-w64_URL      := https://$(SOURCEFORGE_MIRROR)/project/mingw-w64/mingw-w64/mingw-w64-release/$(mingw-w64_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
