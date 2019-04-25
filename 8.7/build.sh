#!/bin/bash

# exit on error
set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 [DEPS] [TARGET]"
  echo "Build libvips for win"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'web'"
  echo "TARGET is the binary target,"
  echo "    defaults to 'x86_64-w64-mingw32.shared'"
  exit 1
fi

. variables.sh

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared}"

# Always checkout a particular revision which will successfully build.
# This ensures that it will not suddenly break a build.
# Note: Must be regularly updated.
revision="1c92269b012c46196b3b0c1660f96ff14ca964e2"
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

if [ "$initialize" = true ] ; then
  # Copy settings
  cp -f $work_dir/settings.mk $mxe_dir

  # Copy our customized tool
  cp -f $work_dir/tools/make-shared-from-static $mxe_dir/tools

  # Copy our customized Meson cross file
  cp -f $work_dir/mxe-crossfile.meson.in $mxe_dir/plugins/meson-wrapper/conf
fi

# Prepare MinGW directories
mkdir -p $mxe_prefix/$target.$deps/mingw/{bin,include,lib}

# Build pe-util, handy for copying DLL dependencies.
make pe-util MXE_TARGETS=`$mxe_dir/ext/config.guess`

# Build MXE's meson-wrapper (needed by pango, GDK-PixBuf, GLib and Orc), 
# gendef (a tool for generating def files from DLLs)
# and libvips (+ dependencies).
make meson-wrapper gendef vips-$deps \
  MXE_PLUGIN_DIRS=$work_dir \
  MXE_TARGETS=$target.$deps

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $deps $target
