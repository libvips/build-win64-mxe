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

cd $mxe_dir

if [ "$DEBUG" = "true" ]; then
  cp -f $work_dir/settings/debug.mk settings.mk
else
  cp -f $work_dir/settings/release.mk settings.mk
fi

# The 'plugins' variable controls which plugins are in use
plugins="plugins/llvm-mingw $work_dir"

if [ -n "$GIT_COMMIT" ]; then
  plugins+=" $work_dir/plugins/nightly"
fi

if [ "$JPEG_IMPL" != "libjpeg-turbo" ]; then
  plugins+=" $work_dir/plugins/$JPEG_IMPL"
fi

if [ "$DISP" = "true" ]; then
  plugins+=" $work_dir/plugins/vipsdisp"
fi

if [ "$HEVC" = "true" ]; then
  plugins+=" $work_dir/plugins/hevc"
fi

if [ "$ZLIB_NG" = "true" ]; then
  plugins+=" $work_dir/plugins/zlib-ng"
fi

# Avoid shipping the gettext DLL (libintl-8.dll),
# use a statically build dummy implementation instead.
# This intentionally disables the i18n features of (GNU)
# gettext, which are probably not needed within Windows.
# See:
# https://github.com/frida/proxy-libintl
# https://github.com/libvips/libvips/issues/1637
plugins+=" $work_dir/plugins/proxy-libintl"

if [ -n "$GIT_COMMIT" ]; then
  # Invalidate build cache, if exists
  rm -f usr/$target.$deps/installed/vips-$deps
fi

# Build gendef (a tool for generating def files from DLLs)
# and libvips (+ dependencies)
make gendef vips-$deps \
  MXE_PLUGIN_DIRS="$plugins" \
  MXE_TARGETS=$target.$deps \
  GIT_COMMIT=$GIT_COMMIT

# Build vipsdisp, if requested
if [ "$DISP" = "true" ]; then
  make vipsdisp \
    MXE_PLUGIN_DIRS="$plugins" \
    MXE_TARGETS=$target.$deps
fi

# Build and bundle llvm-mingw tests when debugging
if [ "$DEBUG" = "true" ]; then
  make test-llvm-mingw \
    MXE_PLUGIN_DIRS="$plugins" \
    MXE_TARGETS=$target.$deps
fi

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $deps $target
