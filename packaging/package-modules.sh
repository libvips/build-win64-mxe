#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]
Package libvips modules in /usr/local/mxe/usr/TARGET/

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
EOF
  exit 0
fi

. variables.sh

target="${1:-x86_64-w64-mingw32.shared}"
arch="${target%%-*}"
type="${target#*.}"
type="${type%%.*}"
build_os=`$mxe_dir/ext/config.guess`

export PATH="$mxe_prefix/$build_os/bin:$mxe_prefix/bin:$mxe_prefix/$target/bin:$PATH"

case "$arch" in
  x86_64) arch=w64 ;;
  i686) arch=w32 ;;
  aarch64) arch=arm64 ;;
esac

# Utilities
strip=$target-strip

# Version number of libvips
vips_version=$(jq -r ".vips" $mxe_prefix/$target/vips-packaging/versions.json)

# Directories
repackage_dir=/var/tmp/vips-dev-$(without_patch $vips_version)
pdb_dir=/var/tmp/vips-pdb-$(without_patch $vips_version)
install_dir=$mxe_prefix/$target
bin_dir=$install_dir/bin
lib_dir=$install_dir/lib
module_dir=$(printf '%s\n' $lib_dir/vips-modules-* | sort -n | tail -1)
module_dir_base=$(basename $module_dir)

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir $pdb_dir
mkdir -p $repackage_dir/bin
mkdir $pdb_dir

# DLL search paths
search_paths=($bin_dir)

if [ "$type" = "shared" ]; then
  search_paths+=($install_dir/${target%%.*}/bin)
fi

zip_suffix="$vips_version"

if [ "$HEVC" = true ]; then
  zip_suffix+="-hevc"
fi

if [ "$DEBUG" = true ]; then
  zip_suffix+="-debug"
fi

echo "Copying libvips modules and dependencies"

# Avoiding copying libvips and glib
whitelist+=(lib{glib-2.0-0,gobject-2.0-0,vips-42}.dll)

mkdir -p $repackage_dir/bin/$module_dir_base

# Copy loadable modules
for module in $module_dir/*.dll; do
  base=$(basename $module .dll)
  cp $module $repackage_dir/bin/$module_dir_base
  [ -f $lib_dir/$base.pdb ] && cp $lib_dir/$base.pdb $pdb_dir

  # Copy the transitive dependencies of the modules
  # which are not yet present in the bin directory.
  binaries=$(peldd $module --clear-path ${search_paths[@]/#/--path } ${whitelist[@]/#/--wlist } --transitive)
  for dll in $binaries; do
    base=$(basename $dll .dll)
    cp -n $dll $repackage_dir/bin
    [ -f $lib_dir/$base.pdb ] && cp -n $lib_dir/$base.pdb $pdb_dir
  done
done

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
if [ "$DEBUG" = "false" ]; then
  [ "$type" = "shared" ] && $strip --strip-unneeded $repackage_dir/bin/*.dll
  $strip --strip-unneeded $repackage_dir/bin/$module_dir_base/*.dll
fi

cd $repackage_dir

if [ "$type" = "shared" ]; then
  mkdir -p lib
  echo "Generating import files"
  . $work_dir/gendeflibs.sh $target
fi

echo "Copying packaging files"

cp $install_dir/vips-packaging/{ChangeLog,LICENSE,README.md} $repackage_dir
cp $install_dir/vips-packaging/versions-modules.json $repackage_dir/versions.json

cd $work_dir

zipfile=vips-dev-$arch-modules-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
(cd /var/tmp && zip -r -qq $work_dir/$zipfile $(basename $repackage_dir))

zipfile=vips-pdb-$arch-modules-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
(cd /var/tmp && zip -r -qq $work_dir/$zipfile $(basename $pdb_dir))
