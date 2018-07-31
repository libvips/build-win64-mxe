#!/bin/bash

# exit on error
set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 [DEPS] [TARGET]"
  echo "Build libvips for win"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'all'"
  echo "TARGET is the binary target, defaults to x86_64-w64-mingw32.shared"
  exit 1
fi

. variables.sh

deps="${1:-all}"
target="${2:-x86_64-w64-mingw32.shared}"

if [ -f "$mxe_dir/Makefile" ]; then
  echo "Skip cloning, MXE already exists at $mxe_dir"
else
  git clone https://github.com/mxe/mxe
fi

cd $mxe_dir

# GLib needs to be built first (otherwise gdk-pixbuf can't find glib-genmarshal)
make glib MXE_TARGETS=${target%%-*}-pc-linux-gnu

# Build libvips and dependencies
make cmake vips-$deps MXE_PLUGIN_DIRS=$work_dir MXE_TARGETS=$target JOBS=4

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $deps $target
