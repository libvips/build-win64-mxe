#!/usr/bin/env bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 [DEPS] [TARGET]"
  echo "Package libvips in mxe/usr/TARGET/"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'web'"
  echo "TARGET is the binary target, defaults to x86_64-w64-mingw32.shared.win32"

  exit 1
fi

. variables.sh

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared.win32}"
arch="${target%%-*}"
type="${target#*.}"
type="${type%%.*}"
build_os=`$mxe_dir/ext/config.guess`

if [ "$arch" = "i686" ]; then
  arch="w32"
elif [ "$arch" = "x86_64" ]; then
  arch="w64"
elif [ "$arch" = "armv7" ]; then
  arch="arm32"
elif [ "$arch" = "aarch64" ]; then
  arch="arm64"
fi

# Make sure that the repackaging dir is empty
rm -rf $repackage_dir
mkdir -p $repackage_dir/bin

# Copy libvips-cpp-42.dll
target_dll="libvips-cpp-42.dll"

zip_suffix="${vips_pre_version:+-$vips_pre_version}"

if [ "$type" = "static" ]; then
  zip_suffix+="-static"
fi

if [ "$MOZJPEG" = "true" ]; then
  zip_suffix+="-mozjpeg"
fi

if [ "$ZLIB_NG" = "false" ]; then
  zip_suffix+="-zlib-vanilla"
fi

if [ "$LLVM" = "true" ] && [[ "$arch" != "arm"* ]]; then
  zip_suffix+="-llvm"
fi

echo "Copying libvips and dependencies"

# Need to whitelist the Universal C Runtime (CRT) DLLs
# Can't do api-ms-win-crt-*-l1-1-0.dll, unfortunately
whitelist=(api-ms-win-crt-{conio,convert,environment,filesystem,heap,locale,math,multibyte,private,process,runtime,stdio,string,time,utility}-l1-1-0.dll)

# CreateEnvironmentBlock, GetUserProfileDirectoryA, etc.
whitelist+=(userenv.dll)

# Copy libvips and dependencies with pe-util
$mxe_prefix/$build_os/bin/peldd \
  $mxe_prefix/$target.$deps/bin/$target_dll \
  --clear-path \
  --path $mxe_prefix/$target.$deps/bin \
  ${whitelist[@]/#/--wlist } \
  -a | xargs cp -t $repackage_dir/bin

echo "Copying install area $mxe_prefix/$target.$deps/"

# Follow symlinks when copying /share, /etc, /lib and /include
cp -Lr $mxe_prefix/$target.$deps/{share,etc,lib,include} $repackage_dir

echo "Generating import files"
./gendeflibs.sh $target.$deps

echo "Cleaning unnecessary files / directories"

# Unnecessary LLVM files
if [ "$LLVM" = "true" ]; then
  rm -rf $repackage_dir/share/clang
  rm -rf $repackage_dir/include/{clang-c,c++,fuzzer,llvm-c,profile,sanitizer,xray}
  rm -rf $repackage_dir/lib/clang
fi

rm -rf $repackage_dir/share/{aclocal,bash-completion,cmake,config.site,doc,gdb,glib-2.0,gtk-2.0,gtk-doc,installed-tests,man,meson,opt-viewer,scan-build,scan-view,thumbnailers,xml,zsh}
rm -rf $repackage_dir/include/cairo
rm -rf $repackage_dir/lib/{*.so*,*cairo*,*gdk*,ldscripts,rustlib,xml2Conf.sh}
rm -rf $repackage_dir/etc/bash_completion.d

find $repackage_dir/lib -name "*.la" -exec rm -f {} \;

# We intentionally disabled the i18n features of (GNU) gettext,
# so the locales are not needed.
rm -rf $repackage_dir/share/locale

# Remove those .gitkeep files
rm $repackage_dir/{share,lib,include}/.gitkeep

echo "Copying vips executables"

# We still need to copy the vips executables
cp $mxe_prefix/$target.$deps/bin/{vips,vipsedit,vipsheader,vipsthumbnail}.exe $repackage_dir/bin/

echo "Strip unneeded symbols"

# Remove all symbols that are not needed
$mxe_prefix/bin/$target.$deps-strip --strip-unneeded $repackage_dir/bin/*.{exe,dll}

echo "Copying packaging files"

cp $mxe_dir/vips-packaging/{AUTHORS,ChangeLog,COPYING,README.md,versions.json} $repackage_dir

echo "Creating $zipfile"

zipfile=$vips_package-dev-$arch-$deps-$vips_version.$vips_patch_version$zip_suffix.zip
rm -f $zipfile
zip -r -qq $zipfile $repackage_dir
