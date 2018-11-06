#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 VERSION [DEPS] [ARCH]"
  echo "Build libvips for Windows in a Docker container"
  echo "VERSION is the name of a versioned subdirectory, e.g. 8.1"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'all'"
  echo "ARCH is the architecture name to build libvips with,"
  echo "    defaults to 'x86_64'"
  exit 1
fi

if [ x$(whoami) == x"root" ]; then
  echo "Please don't run as root -- instead, add yourself to the docker group"
  exit 1
fi

version="$1"
deps="${2:-all}"

# ARCH='i686'
arch="${3:-x86_64}"

# Note: librsvg can't be built statically (it's broken on 2.42, stick 
# with 2.40.20 if we need to build it statically).
# See: https://gitlab.gnome.org/GNOME/librsvg/issues/159
# target="$arch-w64-mingw32.static"
# Note 2: .posix enables C++11/C11 multithreading features by 
# depending on libwinpthreads (will distribute an additional DLL).
# Note 3: Poppler can't be built without .posix (since version 0.70)
# see: https://cgit.freedesktop.org/poppler/poppler/commit/poppler/Annot.cc?id=e5aff4b4fcbd3e1cbdd7d6329c00eee10b36e94d 
target="$arch-w64-mingw32.shared.posix"

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# Ensure latest Debian stable base image, inherit from 
# the Rust toolchain because librsvg needs it.
docker pull rust:stretch

# Create a machine image with all the required build tools pre-installed
docker build --build-arg ARCH=$arch -t libvips-build-win-mxe container

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
