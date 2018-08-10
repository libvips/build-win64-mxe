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

# Copy necessary DLL dependencies
echo Copying libvips and dependencies

rm -rf $repackage_dir

$mxe_dir/tools/copydlldeps.sh -c \
  -f $mxe_prefix/$target/bin/libvips-42.dll \
  -d $repackage_dir/bin \
  -R $mxe_prefix/$target \
  -o $mxe_prefix/bin/$target-objdump > /dev/null 2>&1

# Copy all relevant vips executables to the bin directory
cp $mxe_prefix/$target/bin/vips.exe $repackage_dir/bin
cp $mxe_prefix/$target/bin/vipsedit.exe $repackage_dir/bin
cp $mxe_prefix/$target/bin/vipsheader.exe $repackage_dir/bin
cp $mxe_prefix/$target/bin/vipsthumbnail.exe $repackage_dir/bin

echo Cleaning build $repackage_dir

# Remove unneeded dependencies
( cd $repackage_dir/bin ; rm -f libgomp*.dll )
( cd $repackage_dir/bin ; rm -f libquadmath*.dll )
( cd $repackage_dir/bin ; rm -f libwinpthread*.dll )
( cd $repackage_dir/bin ; rm -f libharfbuzz-subset*.dll )

if [ "$deps" = "web" ]; then
  # Poppler needs this dependency, can safely be removed
  # when targeting web
  ( cd $repackage_dir/bin ; rm -f libstdc++*.dll )
else
  # We don't need these dependencies
  ( cd $repackage_dir/bin ; rm -f libhdf5_hl*.dll )
  ( cd $repackage_dir/bin ; rm -f libMagickWand*.dll )
fi

# Remove all symbols that are not needed
( cd $repackage_dir/bin ; strip --strip-unneeded *.exe )

zipfile=$vips_package-dev-w64-$deps-$vips_version.$vips_micro_version.zip
echo Creating $zipfile
rm -f $zipfile
zip -r -qq $zipfile $repackage_dir
