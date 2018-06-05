#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 VERSION [DEPS]"
  echo "Build libvips for win64 using Docker"
  echo "VERSION is the name of a versioned subdirectory, e.g. 8.1"
  echo "DEPS is the group of dependencies to build libvips with, defaults to 'all'"
  exit 1
fi

VERSION="$1"
DEPS="${2:-all}"

# Note: When 32-bit is needed; change the Docker rustup target (see TODO).
# ARCH='i686'
ARCH='x86_64'

# Note: librsvg can't be build statically (it's broken on 2.42, stick with 2.40.20 if we need to build statically).
# See: https://gitlab.gnome.org/GNOME/librsvg/issues/159
# TARGET="$ARCH-w64-mingw32.static"
TARGET="$ARCH-w64-mingw32.shared"

if ! type docker > /dev/null; then
  echo "Please install docker"
  exit 1
fi

# Ensure latest Debian stable base image, inherit from 
# the Rust toolchain because librsvg needs it.
docker pull rust:stretch

# Create a machine image with all the required build tools pre-installed
docker build -t libvips-build-win64 container

# Run build scripts inside container
docker run --rm -t \
  -u $(id -u):$(id -g) \
  -v $PWD/$VERSION:/data \
  -e "DEPS=$DEPS" \
  -e "MXE_TARGET=$TARGET" \
  libvips-build-win64 \
  sh -c ./build.sh
