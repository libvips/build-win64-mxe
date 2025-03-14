#!/usr/bin/env bash

# exit on error
set -e

for pkg in $PKGS; do
  if [ "$pkg" = "vips-web" ] || [ "$pkg" = "vips-all" ]; then
    for target in $MXE_TARGETS; do
      ./package-vips.sh ${pkg/#vips-} $target
    done
  elif [ "$pkg" = "nip4" ] || [ "$pkg" = "vipsdisp" ]; then
    for target in $MXE_TARGETS; do
      ./package-gtk.sh $pkg $target
    done
  else
    echo "WARNING: Skipping packaging script for '$pkg'." >&2
  fi
done
