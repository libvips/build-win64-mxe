#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 [DEPS] [ARCH] [TYPE]"
  echo "Build libvips for Windows in a Docker container"
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

. $PWD/build/variables.sh

deps="${1:-web}"
arch="${2:-x86_64}"
type="${3:-shared}"

if [[ "$*" == *--with-mozjpeg* ]]; then
  with_mozjpeg=true
else
  with_mozjpeg=false
fi

if [[ "$*" == *--with-llvm* ]]; then
  # This indicates that we don't need to force C++03
  # compilication for some packages, we can safely use
  # libstdc++'s C++11 <thread>, <mutex>, and <future>
  # functionality when compiling with the LLVM toolchain.
  # Note: We don't distribute the winpthreads DLL as
  # libc++ uses Win32 threads to implement the internal
  # threading API.
  threads="posix"
  with_llvm=true
else
  # Use native Win32 threading functions when compiling with
  # GCC because POSIX threads functionality is significantly
  # slower than the native Win32 implementation.
  threads="win32"
  with_llvm=false
fi

if [ "$type" = "static" ] && [ "$deps" == "all" ]; then
  echo "WARNING: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license."
  exit 1
fi

target="$arch-w64-mingw32.$type.$threads"

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
# - inheriting the current uid and gid
# - build dir mounted at /data
docker run --rm -t \
  -u $(id -u):$(id -g) \
  -v $PWD/build:/data \
  -e "MOZJPEG=$with_mozjpeg" \
  -e "LLVM=$with_llvm" \
  libvips-build-win-mxe \
  $deps \
  $target

# test outside the container ... saves us having to install wine inside docker
if [ -x "$(command -v wine)" ]; then
  echo -n "testing build ... "
  wine $PWD/build/$repackage_dir/bin/vips.exe --help > /dev/null
  if [ "$?" -ne "0" ]; then
    echo "WARNING: vips.exe failed to run"
  else
    echo "OK"
  fi
fi
