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

# Always checkout a particular revision which will successfully build.
# This ensures that it will not suddenly break a build.
# Note: Must be regularly updated.
revision="1b2605524df72505e3a82208cfd9c591867d365c"

if [ -f "$mxe_dir/Makefile" ]; then
  echo "Skip cloning, MXE already exists at $mxe_dir"
  cd $mxe_dir && git fetch
else
  git clone https://github.com/mxe/mxe && cd $mxe_dir
fi

branch_name=$(git rev-parse --abbrev-ref HEAD)

# Are we building on the correct branch?
if [ ! "$branch_name" = "vips-$deps" ]; then
  # Reset into a clean state
  git reset --hard $revision && git clean -dfx

  # Does the branch already exists?
  if ! git rev-parse --verify --quiet "vips-$deps" >/dev/null; then
    # Check out new branch and set upstream
    git checkout -b vips-$deps -t origin/master
  else
    # Just a regular checkout
    git checkout vips-$deps
  fi
fi

curr_revision=$(git rev-parse HEAD)

# Is our branch up-to-date?
if [ ! "$curr_revision" = "$revision" ]; then
  git pull && git reset --hard $revision
fi

# Copy settings
cp -f $work_dir/settings.mk $mxe_dir

# Prepare MinGW directories
mkdir -p $mxe_prefix/$target/mingw/{bin,include,lib}

# GLib needs to be built first (otherwise gdk-pixbuf can't find glib-genmarshal)
# Also build pe-util, handy for copying DLL dependencies.
make glib pe-util MXE_TARGETS=`$mxe_dir/ext/config.guess`

# Build libvips and dependencies
make gendef cmake vips-$deps MXE_PLUGIN_DIRS=$work_dir MXE_TARGETS=$target

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh $deps $target
