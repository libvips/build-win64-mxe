#!/bin/bash

. variables.sh

# Copy necessary DLL dependencies
echo Copying libvips and dependencies

rm -rf $repackage_dir

$mxe_dir/tools/copydlldeps.sh -c \
  -f $mxe_prefix/$MXE_TARGET/bin/libvips-42.dll \
  -d $repackage_dir/bin \
  -R $mxe_prefix/$MXE_TARGET \
  -o $mxe_prefix/bin/$MXE_TARGET-objdump > /dev/null 2>&1

# Copy all relevant vips exectuables to the bin directory
cp $mxe_prefix/$MXE_TARGET/bin/vips.exe $repackage_dir/bin
cp $mxe_prefix/$MXE_TARGET/bin/vipsedit.exe $repackage_dir/bin
cp $mxe_prefix/$MXE_TARGET/bin/vipsheader.exe $repackage_dir/bin
cp $mxe_prefix/$MXE_TARGET/bin/vipsthumbnail.exe $repackage_dir/bin

echo Cleaning build $repackage_dir

# Remove unneeded dependencies
( cd $repackage_dir/bin ; rm -f libgomp*.dll )
( cd $repackage_dir/bin ; rm -f libquadmath*.dll )
( cd $repackage_dir/bin ; rm -f libwinpthread*.dll )
( cd $repackage_dir/bin ; rm -f libharfbuzz-subset*.dll )

if [ "$DEPS" = "web" ]; then
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

# ... and test we startup OK
echo -n "testing build ... "
wine $repackage_dir/bin/vips.exe --help > /dev/null
if [ "$?" -ne "0" ]; then
  echo WARNING: vips.exe failed to run
else
  echo ok
fi

zipfile=$vips_package-dev-w64-$DEPS-$vips_version.$vips_micro_version.zip
echo Creating $zipfile
rm -f $zipfile
zip -r -qq $zipfile $repackage_dir
