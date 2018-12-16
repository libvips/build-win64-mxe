# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
JOBS := 4

# Special flags for compiler.
export CPPFLAGS := -D_FORTIFY_SOURCE=2
export CFLAGS   := -s -Os -ffast-math -ftree-vectorize -ffunction-sections \
                   -fPIC $(CPPFLAGS) -static-libgcc
export CXXFLAGS := -s -Os -ffast-math -ftree-vectorize -ffunction-sections \
                   -fPIC $(CPPFLAGS) -static-libgcc -static-libstdc++
export LDFLAGS  := -Wl,--gc-sections -Wl,--strip-all -Wl,--as-needed

# We don't need debugging symbols.
# For e.g. this commit:
# https://github.com/GNOME/librsvg/commit/8215d7f1f581f0aaa317cccc3e974c61d1a6ad84
# adds ~26 MB to the librsvg DLL if we don't install-strip it.
STRIP_LIB := $(true)

# This variable controls which plugins are in use.
# Build with GCC 8.2.
override MXE_PLUGIN_DIRS += plugins/gcc8

# Override GCC patches with 0005-Windows-Don-t-ignore-native-system-header-dir.patch
override gcc_PATCHES := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/gcc-[0-9]*.patch)))