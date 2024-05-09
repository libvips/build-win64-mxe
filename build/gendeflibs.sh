#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [DEPS] [TARGET]
Make .def and .lib files for all the DLLs we've built

OPTIONS:
	--help	Show the help and exit

DEPS:
	The group of dependencies to build libvips with,
	    defaults to 'web'
	Possible values are:
	    - web
	    - all

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

# Enable extended globbing to suppport +(pattern-list) below
shopt -s extglob

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared}"
dlltool=$target.$deps-dlltool

cd $repackage_dir

for dllfile in bin/*.dll; do
  base=$(basename $dllfile .dll)

  # dll names can have extra versioning in ... remove any trailing
  # "-\d+" pattern
  pure="${base%-+([[:digit:]])}"

  defname=$pure.def
  libname=$pure.lib

  if [ ! -f lib/$defname ]; then
    echo "Generating lib/$defname file for $base"
    gendef - $dllfile > lib/$defname 2> /dev/null
  fi

  if [ ! -f lib/$libname ]; then
    echo "Generating lib/$libname file for $base"
    $dlltool -d lib/$defname -l lib/$libname -D $dllfile 2> /dev/null
  fi
done
