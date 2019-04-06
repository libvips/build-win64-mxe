#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 VERSION [DEPS] [ARCH] [TYPE]"
  echo "Build libvips for Windows in a Docker container"
  echo "VERSION is the name of a versioned subdirectory, e.g. 8.7"
  echo "DEPS is the group of dependencies to build libvips with,"
  echo "    defaults to 'web'"
  echo "ARCH is the architecture name to build libvips with,"
  echo "    defaults to 'x86_64'"
  echo "TYPE specifies the type of binary to be created,"
  echo "    defaults to 'shared'"
  exit 1
fi

if [ x$(whoami) == x"root" ]; then
  echo "Please don't run as root -- instead, add yourself to the docker group"
  exit 1
fi

version="$1"
deps="${2:-web}"
arch="${3:-x86_64}"
type="${4:-shared}"

if [ "$type" = "static" ] && [ "$deps" == "all" ]; then
  echo "WARNING: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license."
  exit 1
fi

# Note: Since January 2019 posix threads is used by default.
target="$arch-w64-mingw32.$type"

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# Ensure latest Debian stable base image, inherit from 
# the Rust toolchain because librsvg needs it.
docker pull rust:stretch

# Create a machine image with all the required build tools pre-installed.
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
