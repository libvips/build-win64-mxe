$(PLUGIN_HEADER)

IS_LLVM := $(true)

# Override sub-dependencies
cc_DEPS := llvm-mingw libcxx

# TODO: The armv7-pc-windows-gnu and aarch64-pc-windows-gnu Rust targets are not yet supported.
librsvg_BUILD_aarch64-w64-mingw32 =
librsvg_BUILD_armv7-w64-mingw32   =
rust_BUILD_aarch64-w64-mingw32 =
rust_BUILD_armv7-w64-mingw32   =

# GCC does not support Windows on ARM
gcc_BUILD_aarch64-w64-mingw32 =
gcc_BUILD_armv7-w64-mingw32   =

# Update MinGW-w64 to 04eb1d4
# https://github.com/mirror/mingw-w64/commit/04eb1d4f49830904e200299a04d52b0d1d6c60d2
mingw-w64_VERSION  := 04eb1d4
mingw-w64_CHECKSUM := cf4ada671217c87ca6ca63943621dfdc81b8505472e69d49308a0bd1a171acd4
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mirror-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
