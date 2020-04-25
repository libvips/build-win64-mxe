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

# Update MinGW-w64 to df36f5d
# https://github.com/mirror/mingw-w64/commit/df36f5deda23192d0ee99ffd661ea36df924e667
mingw-w64_VERSION  := df36f5d
mingw-w64_CHECKSUM := 15c40d0d22b7dc813b5f0efd0969dc1b3aab708554cd3a45b834e3029c8ce2d0
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
