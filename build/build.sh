#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [DEPS] [TARGET]
Build Windows binaries for libvips

OPTIONS:
	--help	Show the help and exit

DEPS:
	The group of dependencies to build libvips with,
	    defaults to 'web'
	Possible values are:
	    - web
	    - all

TARGET:
	The binary target,
	    defaults to 'x86_64-w64-mingw32.shared'
	Possible values are:
		- x86_64-w64-mingw32.shared
		- x86_64-w64-mingw32.static
		- i686-w64-mingw32.shared
		- i686-w64-mingw32.static
		- aarch64-w64-mingw32.shared
		- aarch64-w64-mingw32.static
		- armv7-w64-mingw32.shared
		- armv7-w64-mingw32.static
EOF
  exit 0
fi

. variables.sh

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared}"

if [[ "$target" == *.static* ]] && [ "$deps" = "all" ]; then
  echo "ERROR: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license." >&2
  exit 1
fi

# Always checkout a particular revision which will successfully build.
# This ensures that it will not suddenly break a build.
# Note: Must be regularly updated.
revision="8fa8c126f64a0ca6d263c641632645db4f941f00"
initialize=false

if [ -f "$mxe_dir/Makefile" ]; then
  echo "Skip cloning, MXE already exists at $mxe_dir"
  cd $mxe_dir && git fetch
else
  git clone https://github.com/mxe/mxe && cd $mxe_dir
  initialize=true
fi

curr_revision=$(git rev-parse HEAD)

# Is our branch up-to-date?
if [ ! "$curr_revision" = "$revision" ]; then
  git pull && git reset --hard $revision
  initialize=true
fi

if [ "$initialize" = true ]; then
  # Patch MXE to support the ARM/ARM64 targets
  git apply $work_dir/patches/mxe-fixes.patch
fi

if [ "$DEBUG" = "false" ]; then
  settings_suffix="release"
else
  settings_suffix="debug"
fi

if [ "$LLVM" = "true" ]; then
  # Copy LLVM settings
  cp -f $work_dir/settings/llvm-$settings_suffix.mk $mxe_dir/settings.mk
else
  # Copy GCC settings
  cp -f $work_dir/settings/gcc-$settings_suffix.mk $mxe_dir/settings.mk
fi

# The 'plugins' variable controls which plugins are in use
plugins="$work_dir"

if [ -n "$GIT_COMMIT" ]; then
  plugins+=" $work_dir/plugins/nightly"
fi

if [ "$JPEG_IMPL" != "libjpeg-turbo" ]; then
  plugins+=" $work_dir/plugins/$JPEG_IMPL"
fi

if [ "$HEVC" = "true" ]; then
  plugins+=" $work_dir/plugins/hevc"
fi

if [ "$ZLIB_NG" = "true" ]; then
  plugins+=" $work_dir/plugins/zlib-ng"
fi

if [ "$LLVM" = "true" ]; then
  plugins+=" $work_dir/plugins/llvm-mingw"
else
  plugins+=" plugins/gcc14 $work_dir/plugins/gcc"
fi

# Avoid shipping the gettext DLL (libintl-8.dll),
# use a statically build dummy implementation instead.
# This intentionally disables the i18n features of (GNU)
# gettext, which are probably not needed within Windows.
# See:
# https://github.com/frida/proxy-libintl
# https://github.com/libvips/libvips/issues/1637
plugins+=" $work_dir/plugins/proxy-libintl"

# Build pe-util, handy for copying DLL dependencies.
make pe-util \
  IGNORE_SETTINGS=yes \
  MXE_TMP="/var/tmp" \
  MXE_TARGETS=`$mxe_dir/ext/config.guess` \
  MXE_USE_CCACHE=

if [ -n "$GIT_COMMIT" ]; then
  # Invalidate build cache, if exists
  rm -f $mxe_dir/usr/$target.$deps/installed/vips-$deps
fi

# Build gendef (a tool for generating def files from DLLs) 
# and libvips (+ dependencies)
make gendef vips-$deps \
  MXE_PLUGIN_DIRS="$plugins" \
  MXE_TARGETS=$target.$deps \
  GIT_COMMIT=$GIT_COMMIT

# Build and bundle llvm-mingw tests when debugging
if [ "$LLVM" = "true" ] && [ "$DEBUG" = "true" ]; then
  make test-llvm-mingw \
    MXE_PLUGIN_DIRS="$plugins" \
    MXE_TARGETS=$target.$deps
fi

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $deps $target
