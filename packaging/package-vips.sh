#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [DEPS] [MXE_TARGET]
Package libvips in /usr/local/mxe/usr/TARGET/

OPTIONS:
	--help	Show the help and exit

DEPS:
	The group of dependencies with which libvips was built,
	    defaults to 'web'
	Possible values are:
	    - web
	    - all

MXE_TARGET:
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

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared}"
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
repackage_dir=vips-dev-$(without_patch $vips_version)
pdb_dir=vips-pdb-$(without_patch $vips_version)
install_dir=$mxe_prefix/$target
bin_dir=$install_dir/bin
lib_dir=$install_dir/lib
module_dir=$(printf '%s\n' $lib_dir/vips-modules-* | sort -n | tail -1)
module_dir_base=$(basename $module_dir)

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir $pdb_dir
mkdir -p $repackage_dir/{bin,include,lib}
mkdir $pdb_dir

# List of PE targets that need to be copied, including their transitive dependencies and PDBs
pe_targets=($bin_dir/libvips-cpp-42.dll $bin_dir/{vips,vipsedit,vipsheader,vipsthumbnail}.exe)

# DLL search paths
search_paths=($bin_dir)

if [ "$type" = "shared" ]; then
  search_paths+=($install_dir/${target%%.*}/bin)
fi

if [ -d "$module_dir" ]; then
  mkdir -p $repackage_dir/bin/$module_dir_base
  pe_targets+=($module_dir/*.dll)
fi

zip_suffix="$vips_version"

if [ "$type" = "static" ]; then
  zip_suffix+="-static"
fi

if [ "$FFI_COMPAT" = true ]; then
  zip_suffix+="-ffi"
fi

if [ "$HEVC" = true ]; then
  zip_suffix+="-hevc"
fi

if [ "$DEBUG" = true ]; then
  zip_suffix+="-debug"
fi

if [ "$JPEG_IMPL" != "mozjpeg" ]; then
  zip_suffix+="-$JPEG_IMPL"
fi

if [ "$ZLIB_NG" = false ]; then
  zip_suffix+="-zlib-vanilla"
fi

echo "Copying libvips and dependencies"

# Copy libvips and dependencies with pe-util
for pe_target in "${pe_targets[@]}"; do
  [ -f "$pe_target" ] || { echo "WARNING: $pe_target doesn't exist." >&2 ; continue; }

  pe_deps=$(peldd $pe_target --clear-path ${search_paths[@]/#/--path } ${whitelist[@]/#/--wlist } --all)
  for pe_dep in $pe_deps; do
    dir=$(dirname $pe_dep)
    base=$(basename $pe_dep .${pe_dep##*.})
    target_dir="$repackage_dir/bin"
    [ "$dir" = "$module_dir" ] && target_dir+="/$module_dir_base" || true

    cp -n $pe_dep $target_dir

    # Copy PDB files
    [ -f $lib_dir/$base.pdb ] && cp -n $lib_dir/$base.pdb $pdb_dir || true
  done
done

echo "Copying install area $install_dir/"

# Follow symlinks when copying /share, /etc and include directories
cp -Lr $install_dir/{share,etc} $repackage_dir
cp -Lr $install_dir/include/{glib-2.0,vips} $repackage_dir/include
cp -Lr $install_dir/lib/{glib-2.0,pkgconfig} $repackage_dir/lib

cd $repackage_dir

echo "Generating import files"
. $work_dir/gendeflibs.sh $target

echo "Cleaning unnecessary files / directories"

rm -rf share/glib-2.0

# pkg-config files for OpenGL/GLU are not needed
rm -f lib/pkgconfig/{gl,glu}.pc

rm -rf share/{aclocal,bash-completion,cmake,config.site,doc,gdb,gtk-2.0,gtk-doc,installed-tests,man,meson,thumbnailers,xml,zsh}
rm -rf etc/bash_completion.d

# We intentionally disabled the i18n features of (GNU) gettext,
# so the locales are not needed.
rm -rf share/locale

# Remove .gitkeep files
rm -f share/.gitkeep

# Allow sharp to import GLib symbols from libvips-42.dll
sed -i -e 's|#define GLIB_STATIC_COMPILATION 1|/* #undef GLIB_STATIC_COMPILATION */|' \
       -e 's|#define GOBJECT_STATIC_COMPILATION 1|/* #undef GOBJECT_STATIC_COMPILATION */|' \
       lib/glib-2.0/include/glibconfig.h

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
if [ "$DEBUG" = false ]; then
  $strip --strip-unneeded bin/*.{exe,dll}
  [ -d "$module_dir" ] && $strip --strip-unneeded bin/$module_dir_base/*.dll || true
fi

echo "Copying packaging files"

cp $install_dir/vips-packaging/{ChangeLog,LICENSE,README.md,versions.json} .

cd $work_dir

zipfile=vips-dev-$arch-$deps-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $repackage_dir

zipfile=vips-pdb-$arch-$deps-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
zip -r -qq $zipfile $pdb_dir
