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
	    defaults to 'x86_64-w64-mingw32.shared.win32'
	Possible values are:
		- aarch64-w64-mingw32.shared.posix
		- aarch64-w64-mingw32.static.posix
		- armv7-w64-mingw32.shared.posix
		- armv7-w64-mingw32.static.posix
		- i686-w64-mingw32.shared.posix
		- i686-w64-mingw32.shared.win32
		- i686-w64-mingw32.static.posix
		- i686-w64-mingw32.static.win32
		- x86_64-w64-mingw32.shared.posix
		- x86_64-w64-mingw32.shared.win32
		- x86_64-w64-mingw32.static.posix
		- x86_64-w64-mingw32.static.win32
EOF
  exit 0
fi

. variables.sh

deps="${1:-web}"
target="${2:-x86_64-w64-mingw32.shared.win32}"
dlltool=$target.$deps-dlltool

cd $repackage_dir

for dllfile in bin/*.dll; do
  base=$(basename $dllfile .dll)

  # dll names can have extra versioning in ... remove any trailing
  # "-\d+" pattern
  pure=$base
  if [[ $pure =~ (.*)-[0-9]+$ ]]; then
    pure=${BASH_REMATCH[1]}
  fi

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
