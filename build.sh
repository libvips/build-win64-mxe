#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 VERSION [DEPS]"
  echo "Build libvips for win64 in a Docker container"
  echo "VERSION is the name of a versioned subdirectory, e.g. 8.1"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'all'"
  exit 1
fi

if [ x$(whoami) == x"root" ]; then
  echo "Please don't run as root -- instead, add yourself to the docker group"
  exit 1
fi

version="$1"
deps="${2:-all}"

# Note: When 32-bit is needed, also change the Docker rustup target (see TODO).
# ARCH='i686'
arch='x86_64'

# Note: librsvg can't be build statically (it's broken on 2.42, stick 
# with 2.40.20 if we need to build statically).
# See: https://gitlab.gnome.org/GNOME/librsvg/issues/159
# target="$arch-w64-mingw32.static"
target="$arch-w64-mingw32.shared"

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# Ensure latest Debian stable base image, inherit from 
# the Rust toolchain because librsvg needs it.
docker pull rust:stretch

# Create a machine image with all the required build tools pre-installed
docker build -t libvips-build-win-mxe container

# Run build scripts inside container
docker run --rm -t -u $(id -u):$(id -g) -v $PWD/$version:/data \
  libvips-build-win-mxe $deps $target

# test outside the container ... saves us having to install wine inside docker
if [ -x "$(command -v wine)" ]; then
  echo -n "testing build ... "
  wine $version/vips-dev-$version/bin/vips.exe --help > /dev/null
  if [ "$?" -ne "0" ]; then
    echo WARNING: vips.exe failed to run
  else
    echo ok
  fi
fi
