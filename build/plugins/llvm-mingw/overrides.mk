$(PLUGIN_HEADER)

IS_LLVM := $(true)

# Override sub-dependencies
cc_DEPS := llvm

# TODO: The armv7-pc-windows-gnu and aarch64-pc-windows-gnu Rust targets are not yet supported.
librsvg_BUILD_aarch64-w64-mingw32 =
librsvg_BUILD_armv7-w64-mingw32   =
rust_BUILD_aarch64-w64-mingw32 =
rust_BUILD_armv7-w64-mingw32   =

# GCC does not support Windows on ARM
gcc_BUILD_aarch64-w64-mingw32 =
gcc_BUILD_armv7-w64-mingw32   =

# Update MinGW-w64 to a25dc93
# https://github.com/mirror/mingw-w64/tarball/a25dc933f3d3ed6c8529fb24b7ae393f8792ca69
mingw-w64_VERSION  := a25dc93
mingw-w64_CHECKSUM := cd3ebd8b2644e06453c538d8cf7f22b0329c259a934efce6ddd489c48a8acd64
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mirror-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
