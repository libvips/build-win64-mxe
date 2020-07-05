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

# Update MinGW-w64 to 82a4665
# https://github.com/mirror/mingw-w64/tarball/82a466591f4bf62e4b789f30810208ba6b730759
mingw-w64_VERSION  := 82a4665
mingw-w64_CHECKSUM := 22cbfeba4a90eab9a8af388d26515ac50bf23d0f80d289cb72e6c60bc7fb7c5a
mingw-w64_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/mingw-w64-[0-9]*.patch)))
mingw-w64_SUBDIR   := mirror-mingw-w64-$(mingw-w64_VERSION)
mingw-w64_FILE     := mirror-mingw-w64-$(mingw-w64_VERSION).tar.gz
mingw-w64_URL      := https://github.com/mirror/mingw-w64/tarball/$(mingw-w64_VERSION)/$($(PKG)_FILE)

# Do not build pthreads
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
