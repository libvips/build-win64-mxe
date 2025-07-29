#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [PKG] [TARGET]
Package GTK apps in /usr/local/mxe/usr/TARGET/

OPTIONS:
	--help	Show the help and exit

PKG:
	The GTK application to be packaged,
	    defaults to 'nip4'
	Possible values are:
	    - nip4
	    - vipsdisp

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

package="${1:-nip4}"
target="${2:-x86_64-w64-mingw32.shared}"
arch="${target%%-*}"
build_os=`$mxe_dir/ext/config.guess`

export PATH="$mxe_prefix/$build_os/bin:$mxe_prefix/bin:$mxe_prefix/$target/bin:$PATH"

# Utilities
strip=$target-strip

# Version number of nip4 or vipsdisp
package_version=$(jq -r ".$package" $mxe_prefix/$target/vips-packaging/versions-$package.json)

# Directories
repackage_dir=/var/tmp/$package
pdb_dir=/var/tmp/$package-pdb
install_dir=$mxe_prefix/$target
bin_dir=$install_dir/bin
lib_dir=$install_dir/lib
module_dir=$(printf '%s\n' $lib_dir/vips-modules-* | sort -n | tail -1)
module_dir_base=$(basename $module_dir)

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir $pdb_dir
mkdir -p $repackage_dir/bin
mkdir $pdb_dir

# List of PE targets that need to be copied, including their transitive dependencies and PDBs
pe_targets=($bin_dir/libvips-cpp-42.dll $bin_dir/{$package,gdbus}.exe)

# DLL search paths
search_paths=($bin_dir $install_dir/${target%%.*}/bin)

if [ -d "$module_dir" ]; then
  mkdir -p $repackage_dir/bin/$module_dir_base
  pe_targets+=($module_dir/*.dll)
fi

zip_suffix="$package_version"

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

echo "Copying $package and dependencies"

# Whitelist dwrite.dll, hid.dll and opengl32.dll for GTK
whitelist+=(dwrite.dll hid.dll opengl32.dll)

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

# Follow symlinks when copying /share and /etc directories
cp -Lr $install_dir/{share,etc} $repackage_dir

cd $repackage_dir

echo "Cleaning unnecessary files / directories"

# We need to distribute share/glib-2.0/schemas/* for GTK apps
# Note: you may also need to set the XDG_DATA_DIRS env variable, see:
# https://stackoverflow.com/a/28962391
rm -rf share/glib-2.0/{codegen,dtds,gdb}

rm -rf share/{aclocal,bash-completion,cmake,config.site,doc,gdb,gtk-2.0,gtk-doc,installed-tests,man,meson,thumbnailers,xml,zsh}
rm -rf etc/bash_completion.d

# We intentionally disabled the i18n features of (GNU) gettext,
# so the locales are not needed.
rm -rf share/locale

# Remove .gitkeep files
rm -f share/.gitkeep

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
if [ "$DEBUG" = false ]; then
  $strip --strip-unneeded bin/*.{exe,dll}
  [ -d "$module_dir" ] && $strip --strip-unneeded bin/$module_dir_base/*.dll || true
fi

echo "Copying packaging files"

cp $install_dir/vips-packaging/{ChangeLog,LICENSE,README.md,versions.json} .
cp $install_dir/vips-packaging/versions-$package.json .

cd $work_dir

zipfile=$package-$arch-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
(cd $repackage_dir && zip -r -qq $work_dir/$zipfile .)

zipfile=$package-pdb-$arch-$zip_suffix.zip

echo "Creating $zipfile"

rm -f $zipfile
(cd $pdb_dir && zip -r -qq $work_dir/$zipfile .)
