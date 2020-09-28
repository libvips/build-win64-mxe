$(PLUGIN_HEADER)

IS_LLVM := $(true)

# Override sub-dependencies
cc_DEPS   := llvm

# GCC does not support Windows on ARM
gcc_BUILD_aarch64-w64-mingw32 =
gcc_BUILD_armv7-w64-mingw32   =

# Update MinGW-w64 to 8.0.0
mingw-w64_VERSION  := 8.0.0
mingw-w64_CHECKSUM := 44c740ea6ab3924bc3aa169bad11ad3c5766c5c8459e3126d44eabb8735a5762
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mingw-w64-v$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-v$(mingw-w64_VERSION).tar.bz2
mingw-w64_URL      := https://$(SOURCEFORGE_MIRROR)/project/mingw-w64/mingw-w64/mingw-w64-release/$(mingw-w64_FILE)

# libc++ uses Win32 threads to implement the internal
# threading API, so we do not need to build pthreads.
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
