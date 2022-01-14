#!/usr/bin/env bash

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]
Package libvips modules in mxe/usr/TARGET/

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

target="${1-x86_64-w64-mingw32.shared}"
arch="${target%%-*}"
type="${target#*.}"
type="${type%%.*}"
build_os=`$mxe_dir/ext/config.guess`

export PATH="$mxe_prefix/$build_os/bin:$mxe_prefix/bin:$mxe_prefix/$target/bin:$PATH"

case "$arch" in
  x86_64) arch=w64 ;;
  i686) arch=w32 ;;
  aarch64) arch=arm64 ;;
  armv7) arch=arm32 ;;
esac

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir $pdb_dir
mkdir -p $repackage_dir/bin
mkdir $pdb_dir

zip_suffix="${vips_pre_version:+-$vips_pre_version}"

if [ "$HEVC" = "true" ]; then
  zip_suffix+="-hevc"
fi

if [ "$DEBUG" = "true" ]; then
  zip_suffix+="-debug"
fi

# Utilities
strip=$target-strip

# Directories
install_dir=$mxe_prefix/$target
bin_dir=$install_dir/bin
lib_dir=$install_dir/lib

# Ensure module_dir is set correctly when building nightly versions
if [ -n "$GIT_COMMIT" ]; then
  module_dir=$(printf '%s\n' $install_dir/lib/vips-modules-* | sort -n | tail -1)
else
  module_dir=$lib_dir/vips-modules-$vips_version
fi
module_dir_base=${module_dir##*/}

echo "Copying libvips modules and dependencies"

# Whitelist the API set DLLs
# Can't do api-ms-win-crt-*-l1-1-0.dll, unfortunately
whitelist=(api-ms-win-crt-{conio,convert,environment,filesystem,heap,locale,math,multibyte,private,process,runtime,stdio,string,time,utility}-l1-1-0.dll)

# Whitelist ntdll.dll for Rust
# See: https://github.com/rust-lang/rust/pull/108262
whitelist+=(ntdll.dll)

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
  binaries=$(peldd $module --clear-path --path $bin_dir ${whitelist[@]/#/--wlist } --transitive)
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

if [ "$type" = "shared" ]; then
  mkdir -p $repackage_dir/lib
  echo "Generating import files"
  ./gendeflibs.sh $target
fi

echo "Copying packaging files"

cp $install_dir/vips-packaging/{ChangeLog,LICENSE,README.md} $repackage_dir
cp $install_dir/vips-packaging/versions-modules.json $repackage_dir/versions.json

zipfile=$vips_package-dev-$arch-modules-$vips_version${vips_patch_version:+.$vips_patch_version}$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $repackage_dir

zipfile=$vips_package-pdb-$arch-modules-$vips_version${vips_patch_version:+.$vips_patch_version}$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $pdb_dir
