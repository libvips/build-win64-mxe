#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 [DEPS] [TARGET]"
  echo "Package libvips in mxe/usr/TARGET/"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'all'"
  echo "TARGET is the binary target, defaults to x86_64-w64-mingw32.shared"

  exit 1
fi

. variables.sh

deps="${1:-all}"
target="${2:-x86_64-w64-mingw32.shared}"
arch=${target%%-*}
type="${target#*.}"
build_os=`$mxe_dir/ext/config.guess`

if [ "$arch" = "i686" ]; then
  arch="32"
else
  arch="64"
fi

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir
mkdir -p $repackage_dir/bin

zip_suffix="-exe"

if [ "$type" = "static" ]; then
  zip_suffix="-static-exe"
fi

echo "Copying vips executables"

# We still need to copy the vips executables
cp $mxe_prefix/$target.$deps/bin/{vips,vipsedit,vipsheader,vipsthumbnail}.exe $repackage_dir/bin/

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
strip --strip-unneeded $repackage_dir/bin/*.exe

echo "Copying packaging files"

cp $mxe_dir/vips-packaging/{COPYING,ChangeLog,README.md,AUTHORS} $repackage_dir

echo "Creating $zipfile"

zipfile=$vips_package-dev-w$arch-$deps-$vips_version.$vips_micro_version$zip_suffix.zip
rm -f $zipfile
zip -r -qq $zipfile $repackage_dir
