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

# Update MinGW-w64 to 99ca150
# https://github.com/mirror/mingw-w64/commit/99ca150e774f752bf88d6971386c9e327ee2fc1e
mingw-w64_VERSION  := 99ca150
mingw-w64_CHECKSUM := 89b8e3582ad8c3e0697d28f80baed516fbf0ac2f9ebb67d83ed15dc8b9de85b3
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mirror-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
