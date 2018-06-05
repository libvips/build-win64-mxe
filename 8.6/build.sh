#!/bin/bash

# The whole build process

. variables.sh

if [ -f "$mxe_dir/Makefile" ]
then
  echo "Skip cloning, MXE already exists at $mxe_dir"
else
  git clone https://github.com/mxe/mxe
fi

cd $mxe_dir

# GLib needs to be builded first (otherwise gdk-pixbuf can't find glib-genmarshal)
make glib MXE_TARGETS=${MXE_TARGET%%-*}-pc-linux-gnu

# Build libvips and dependencies
make cmake vips-$DEPS MXE_PLUGIN_DIRS=$work_dir MXE_TARGETS=$MXE_TARGET JOBS=4

cd $work_dir

# Packaging
. $work_dir/package-vipsdev.sh