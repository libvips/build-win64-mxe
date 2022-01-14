#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]
Build Windows binaries for libvips

OPTIONS:
	--help	Show the help and exit

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

target="${1:-x86_64-w64-mingw32.shared}"

# Always checkout a particular revision which will successfully build.
# This ensures that it will not suddenly break a build.
# Note: Must be regularly updated.
revision="b50e0b7be2f4f0352fae0e161ed2844ec4826b48"
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

if [ "$DEBUG" = "true" ]; then
  cp -f $work_dir/settings/debug.mk $mxe_dir/settings.mk
else
  cp -f $work_dir/settings/release.mk $mxe_dir/settings.mk
fi

# The 'plugins' variable controls which plugins are in use
plugins="$work_dir"

if [ -n "$GIT_COMMIT" ]; then
  plugins+=" $work_dir/plugins/nightly"
fi

if [ "$MODULES" = "true" ]; then
  plugins+=" $work_dir/plugins/modular"
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

plugins+=" $work_dir/plugins/llvm-mingw"

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
  rm -f $mxe_dir/usr/$target/installed/vips
fi

# Build gendef (a tool for generating def files from DLLs) 
# and libvips (+ dependencies)
make gendef vips \
  MXE_PLUGIN_DIRS="$plugins" \
  MXE_TARGETS=$target \
  GIT_COMMIT=$GIT_COMMIT

# Build and bundle llvm-mingw tests when debugging
if [ "$DEBUG" = "true" ]; then
  make test-llvm-mingw \
    MXE_PLUGIN_DIRS="$plugins" \
    MXE_TARGETS=$target
fi

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $target

if [ "$MODULES" = "true" ]; then
  . $work_dir/package-modules.sh $target
fi
