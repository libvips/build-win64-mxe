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

# Update MinGW-w64 to 0d54333
# https://github.com/mirror/mingw-w64/commit/0d543332e3153cf32986f7274f819022eceac6ff
mingw-w64_VERSION  := 0d54333
mingw-w64_CHECKSUM := a28923ac3a432ccc91c36833174ae36aaaa958860286b145c346288fc7a3f3d5
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
