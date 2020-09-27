#!/usr/bin/env bash

if [[ "$*" == *--help* ]]; then
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [DEPS] [ARCH] [TYPE]
Build libvips for Windows in a Docker container

OPTIONS:
	--help		Show the help and exit
	--with-mozjpeg	Build with MozJPEG instead of libjpeg-turbo
	--with-hevc	Build libheif with the HEVC-related dependencies
	--with-llvm	Build with llvm-mingw

DEPS:
	The group of dependencies to build libvips with,
	    defaults to 'web'
	Possible values are:
	    - web
	    - all

ARCH:
	The Windows architecture to target,
	    defaults to 'x86_64'
	Possible values are:
	    - x86_64
	    - i686
	    - aarch64
	    - armv7

TYPE:
	Specifies the type of binary to be created,
	    defaults to 'shared'
	Possible values are:
	    - shared
	    - static
EOF
  exit 0
fi

if [ $EUID -eq 0 ]; then
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

if [[ "$*" == *--with-hevc* ]]; then
  with_hevc=true
else
  with_hevc=false
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
elif [ "$arch" = "aarch64" ] || [ "$arch" = "armv7" ]; then
  # Force the LLVM toolchain for the ARM/ARM64 targets,
  # GCC does not support Windows on ARM.
  threads="posix"
  with_llvm=true
else
  # Use native Win32 threading functions when compiling with
  # GCC because POSIX threads functionality is significantly
  # slower than the native Win32 implementation.
  threads="win32"
  with_llvm=false
fi

if [ "$with_hevc" = "true" ] && [ "$deps" = "web" ]; then
  echo "ERROR: The HEVC-related dependencies can only be built for the \"all\" variant."
  exit 1
fi

if [ "$type" = "static" ] && [ "$deps" = "all" ]; then
  echo "ERROR: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license."
  exit 1
fi

target="$arch-w64-mingw32.$type.$threads"

# Is docker available?
if ! [ -x "$(command -v docker)" ]; then
  echo "Please install docker"
  exit 1
fi

# Ensure latest Debian stable base image.
docker pull buildpack-deps:buster

# Create a machine image with all the required build tools pre-installed.
docker build -t libvips-build-win-mxe container

# Run build scripts inside container
# - inheriting the current uid and gid
# - build dir mounted at /data
docker run --rm -t \
  -u $(id -u):$(id -g) \
  -v $PWD/build:/data \
  -e "MOZJPEG=$with_mozjpeg" \
  -e "HEVC=$with_hevc" \
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
