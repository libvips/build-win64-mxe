#!/usr/bin/env bash

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]
Package libvips in mxe/usr/TARGET/

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

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir $pdb_dir
mkdir -p $repackage_dir/{bin,include,lib}
mkdir $pdb_dir

# Utilities
strip=$target-strip

# Directories
install_dir=$mxe_prefix/$target
bin_dir=$install_dir/bin
lib_dir=$install_dir/lib

# List of PE targets that need to be copied, including their transitive dependencies and PDBs
pe_targets=($bin_dir/libvips-cpp-42.dll $bin_dir/{vips,vipsedit,vipsheader,vipsthumbnail}.exe)

zip_suffix="${vips_pre_version:+-$vips_pre_version}"

if [ "$type" = "static" ]; then
  zip_suffix+="-static"
fi

if [ "$FFI_COMPAT" = "true" ]; then
  zip_suffix+="-ffi"
fi

if [ "$DISP" = "true" ]; then
  zip_suffix+="-disp"
  pe_targets+=($bin_dir/vipsdisp.exe $bin_dir/gdbus.exe)
fi

if [ "$HEVC" = "true" ]; then
  zip_suffix+="-hevc"
fi

if [ "$DEBUG" = "true" ]; then
  zip_suffix+="-debug"
fi

if [ "$JPEG_IMPL" != "mozjpeg" ]; then
  zip_suffix+="-$JPEG_IMPL"
fi

if [ "$ZLIB_NG" = "false" ]; then
  zip_suffix+="-zlib-vanilla"
fi

echo "Copying libvips and dependencies"

# Whitelist the API set DLLs
# Can't do api-ms-win-crt-*-l1-1-0.dll, unfortunately
whitelist=(api-ms-win-crt-{conio,convert,environment,filesystem,heap,locale,math,multibyte,private,process,runtime,stdio,string,time,utility}-l1-1-0.dll)

# Whitelist bcryptprimitives.dll for Rust
# See: https://github.com/rust-lang/rust/pull/84096
whitelist+=(bcryptprimitives.dll)

# Whitelist ntdll.dll for Rust
# See: https://github.com/rust-lang/rust/pull/108262
whitelist+=(ntdll.dll)

# Whitelist api-ms-win-core-synch-l1-2-0.dll for Rust
# See: https://github.com/rust-lang/rust/pull/121317
whitelist+=(api-ms-win-core-synch-l1-2-0.dll)

# Whitelist dwrite.dll, hid.dll and opengl32.dll for GTK
if [ "$DISP" = "true" ]; then
   whitelist+=(dwrite.dll hid.dll opengl32.dll)
fi

# Copy libvips and dependencies with pe-util
for pe_target in "${pe_targets[@]}"; do
  [ -f "$pe_target" ] || { echo "WARNING: $pe_target doesn't exist." >&2 ; continue; }

  pe_deps=$(peldd $pe_target --clear-path --path $bin_dir ${whitelist[@]/#/--wlist } --all)
  for pe_dep in $pe_deps; do
    dir=$(dirname $pe_dep)
    base=$(basename $pe_dep .${pe_dep##*.})

    cp -n $pe_dep $repackage_dir/bin

    # Copy PDB files
    [ -f $lib_dir/$base.pdb ] && cp -n $lib_dir/$base.pdb $pdb_dir
  done
done

echo "Copying include directories"

# Follow symlinks when copying include directories
cp -Lr $install_dir/include/{glib-2.0,vips} $repackage_dir/include
cp -Lr $lib_dir/glib-2.0 $repackage_dir/lib

echo "Generating import files"
./gendeflibs.sh $target

# Allow sharp to import GLib symbols from libvips-42.dll
sed -i -e 's|#define GLIB_STATIC_COMPILATION 1|/* #undef GLIB_STATIC_COMPILATION */|' \
       -e 's|#define GOBJECT_STATIC_COMPILATION 1|/* #undef GOBJECT_STATIC_COMPILATION */|' \
       $repackage_dir/lib/glib-2.0/include/glibconfig.h

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
if [ "$DEBUG" = "false" ]; then
  $strip --strip-unneeded $repackage_dir/bin/*.{exe,dll}
fi

echo "Copying packaging files"

cp $install_dir/vips-packaging/{ChangeLog,LICENSE,README.md,versions.json} $repackage_dir
[ "$DISP" = "true" ] && cp $install_dir/vips-packaging/versions-disp.json $repackage_dir

zipfile=$vips_package-dev-$arch-web-$vips_version${vips_patch_version:+.$vips_patch_version}$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $repackage_dir

zipfile=$vips_package-pdb-$arch-web-$vips_version${vips_patch_version:+.$vips_patch_version}$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $pdb_dir
