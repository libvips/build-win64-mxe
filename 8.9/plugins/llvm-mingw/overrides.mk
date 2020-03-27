$(PLUGIN_HEADER)

IS_LLVM := $(true)

# Override sub-dependencies
cc_DEPS := llvm-mingw libcxx

# TODO: The armv7-pc-windows-gnu and aarch64-pc-windows-gnu Rust targets are not yet supported.
librsvg_BUILD_armv7-w64-mingw32   =
librsvg_BUILD_aarch64-w64-mingw32 =
rust_BUILD_armv7-w64-mingw32   =
rust_BUILD_aarch64-w64-mingw32 =

# GCC does not support Windows on ARM
gcc_BUILD_armv7-w64-mingw32   =
gcc_BUILD_aarch64-w64-mingw32 =

# Update MinGW-w64 to 823bc20
# https://github.com/mirror/mingw-w64/commit/823bc20b3c9aea724acbd60400a923c35757b08c
mingw-w64_VERSION  := 823bc20
mingw-w64_CHECKSUM := 8109b0ca197e27fe9801389e48feeb95386548b7d81f4ca1e2d9cba00c7b6e8c
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
