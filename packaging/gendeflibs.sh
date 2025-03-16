#!/usr/bin/env bash

# exit on error
set -e

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [TARGET]
Make .def and .lib files for all the DLLs we've built

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

# Enable extended globbing to suppport +(pattern-list) below
shopt -s extglob

target="${1:-x86_64-w64-mingw32.shared}"
dlltool=$target-dlltool

dlls=(bin/*.dll)

[ -f "${dlls[0]}" ] || { echo "WARNING: No DLLs found" >&2 ; exit 0; }

for dllfile in "${dlls[@]}"; do
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
