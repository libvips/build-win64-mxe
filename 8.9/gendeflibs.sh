#!/usr/bin/env bash

# exit on error
set -e

if [ $# -lt 1 ]; then
  echo "Usage: $0 [TARGET]"
  echo "Make .def and .lib files for all the DLLs we've built"
  echo "TARGET is the binary target, defaults to x86_64-w64-mingw32.shared"
  exit 1
fi

. variables.sh

target="${1:-x86_64-w64-mingw32.shared}"
dlltool=$mxe_prefix/bin/$target-dlltool
gendeftool=$mxe_prefix/$target/bin/gendef

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
    $gendeftool - $dllfile > lib/$defname 2> /dev/null
  fi

  if [ ! -f lib/$libname ]; then
    echo "Generating lib/$libname file for $base"
    $dlltool -d lib/$defname -l lib/$libname -D $dllfile 2> /dev/null
  fi
done
