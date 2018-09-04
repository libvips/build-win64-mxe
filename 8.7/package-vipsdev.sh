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
build_os=`$mxe_dir/ext/config.guess`

if [ "$arch" = "i686" ]; then
  arch="32"
else
  arch="64"
fi

echo "Copying libvips and dependencies"

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir
mkdir -p $repackage_dir/bin

if [ "$slim_build" = true ]; then
  # Slim build? Only copy libvips-42.dll and dependencies with pe-util
  $mxe_prefix/$build_os/bin/peldd \
    $mxe_prefix/$target/bin/libvips-42.dll \
    --clear-path \
    --path $mxe_prefix/$target/bin \
    -a \
    -w USERENV.dll \
    -w USP10.dll \
    -w DNSAPI.dll \
    -w IPHLPAPI.DLL \
    -w MSIMG32.DLL | xargs cp -t $repackage_dir/bin
else
  # No slim build? Copy libvips-cpp-42.dll and dependencies with pe-util
  # + additional headers, link libraries and def files
  $mxe_prefix/$build_os/bin/peldd \
    $mxe_prefix/$target/bin/libvips-cpp-42.dll \
    --clear-path \
    --path $mxe_prefix/$target/bin \
    -a \
    -w USERENV.dll \
    -w USP10.dll \
    -w DNSAPI.dll \
    -w IPHLPAPI.DLL \
    -w MSIMG32.DLL | xargs cp -t $repackage_dir/bin

  echo "Copying install area $mxe_prefix/$target/"

  # Follow symlinks when copying /share and /etc
  cp -Lr $mxe_prefix/$target/{share,etc} $repackage_dir

  # Copy everything from /lib and /include, then delete the symlinks
  cp -r $mxe_prefix/$target/{lib,include} $repackage_dir
  find $repackage_dir/{lib,include} -type l -exec rm -f {} \;

  echo "Copying packaging files"

  cp $mxe_dir/vips-packaging/{COPYING,ChangeLog,README.md,AUTHORS} $repackage_dir

  echo "Generating import files"
  ./gendeflibs.sh $target

  echo "Cleaning unnecessary files / directories"

  # TODO Do we need to keep /share/doc and /share/gtk-doc?
  rm -rf $repackage_dir/share/{aclocal,bash-completion,cmake,config.site,doc,gdb,glib-2.0,gtk-2.0,gtk-doc,man,thumbnailers,xml}

  rm -rf $repackage_dir/include/cairo

  rm -rf $repackage_dir/lib/{*cairo*,*gdk*,ldscripts}
  find $repackage_dir/lib -name "*.la" -exec rm -f {} \;

  # We only support GB and de locales
  find $repackage_dir/share/locale -mindepth 1 -maxdepth 1 -type d ! -name "en_GB" ! -name "de" -exec rm -rf {} \;

  # Remove those .gitkeep files
  rm $repackage_dir/{include/.gitkeep,lib/.gitkeep,share/.gitkeep}
fi

echo "Copying vips executables"

# We still need to copy the vips executables.
cp $mxe_prefix/$target/bin/{vips,vipsedit,vipsheader,vipsthumbnail}.exe $repackage_dir/bin/

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
strip --strip-unneeded $repackage_dir/bin/*.exe

echo "Creating $zipfile"

zipfile=$vips_package-dev-w$arch-$deps-$vips_version.$vips_micro_version.zip
rm -f $zipfile
zip -r -qq $zipfile $repackage_dir
