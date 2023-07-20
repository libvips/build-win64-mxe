#!/usr/bin/env bash

function usage()
{
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [DEPS] [ARCH] [TYPE]
Build Windows binaries for libvips in a container

OPTIONS:
	--help			Show the help and exit
	-c, --commit <COMMIT>	The commit to build libvips from
	-r, --ref <REF>		The branch or tag to build libvips from
	--tmpdir <DIR>		Where intermediate files should be stored (default in /var/tmp/mxe)
	--nightly		Build libvips from tip-of-tree (alias of -r master)
	--with-hevc		Build libheif with the HEVC-related dependencies
	--with-debug		Build binaries without optimizations to improve debuggability
	--without-llvm		Build binaries with GCC
	--without-mozjpeg	Build binaries with libjpeg-turbo
	--without-zlib-ng	Build binaries with vanilla zlib

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
	    - aarch64 (disables --without-llvm)
	    - armv7 (disables --without-llvm)

TYPE:
	Specifies the type of binary to be created,
	    defaults to 'shared'
	Possible values are:
	    - shared
	    - static
EOF

  if [ -n "$1" ]; then
    exit "$1"
  fi
}

. $PWD/build/variables.sh

# Default arguments
git_commit=""
git_ref=""
tmpdir="/var/tmp/mxe"
with_hevc=false
with_debug=false
with_llvm=true
with_mozjpeg=true
with_zlib_ng=true

# Parse arguments
POSITIONAL=()

while [ $# -gt 0 ]; do
  case $1 in
    -h|--help) usage 0 ;;
    -c|--commit) git_commit="$2"; shift ;;
    -r|--ref) git_ref="$2"; shift ;;
    --tmpdir) tmpdir="$2"; shift ;;
    --nightly) git_ref="master" ;;
    --with-hevc) with_hevc=true ;;
    --with-debug) with_debug=true ;;
    --without-llvm) with_llvm=false ;;
    --without-mozjpeg) with_mozjpeg=false ;;
    --without-zlib-ng) with_zlib_ng=false ;;
    -*)
      echo "ERROR: Unknown option $1" >&2
      usage 1
      ;;
    *) POSITIONAL+=("$1") ;;
  esac
  shift
done

# Restore positional parameters
set -- "${POSITIONAL[@]}"

deps="${1:-web}"
arch="${2:-x86_64}"
type="${3:-shared}"

if [ "$with_llvm" = "true" ]; then
  # This indicates that we don't need to force C++03
  # compilication for some packages, we can safely use
  # libstdc++'s C++11 <thread>, <mutex>, and <future>
  # functionality when compiling with the LLVM toolchain.
  # Note: We don't distribute the winpthreads DLL as
  # libc++ uses Win32 threads to implement the internal
  # threading API.
  threads="posix"
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
  # Use Dwarf-2 (DW2) stack frame unwinding for i686, as
  # there is a performance overhead when using SJLJ.
  # Furthermore, the dwarf exception model is basically
  # used by default by all popular native GCC-based MinGW
  # toolchains (such as Rust, MSYS2, Fedora 32+, etc.).
  # See: https://fedoraproject.org/wiki/Changes/Mingw32GccDwarf2
  if [ "$arch" = "i686" ]; then
    unwind="dw2"
  fi
fi

if [ "$with_hevc" = "true" ] && [ "$deps" = "web" ]; then
  echo "ERROR: The HEVC-related dependencies can only be built for the \"all\" variant." >&2
  exit 1
fi

if [ "$type" = "static" ] && [ "$deps" = "all" ]; then
  echo "ERROR: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license." >&2
  exit 1
fi

if [ -n "$git_commit" ] && [ -n "$git_ref" ]; then
  echo "ERROR: The --commit and --ref options are mutually exclusive." >&2
  exit 1
fi

if [ -n "$git_ref" ]; then
  git_commit=$(git ls-remote --heads --tags --refs https://github.com/libvips/libvips.git $git_ref | awk '{print $1}')
  if [ -z "$git_commit" ]; then
    echo "ERROR: Couldn't find remote ref $git_ref in the libvips repository." >&2
    exit 1
  fi
fi

# GitHub's tarball API requires the short SHA commit as the directory name
git_commit="${git_commit:0:7}"

target="$arch-w64-mingw32.$type.$threads${unwind:+.$unwind}"

if [ "$with_debug" = "true" ]; then
  target+=".debug"
fi

# Check whether we can build and run OCI-compliant containers
if [ -x "$(command -v podman)" ]; then
  oci_runtime=podman
elif [ -x "$(command -v docker)" ]; then
  oci_runtime=docker
else
  echo "ERROR: OCI-compliant container runtime not found. Please install Podman or Docker." >&2
  exit 1
fi

# Ensure temporary dir exists
mkdir -p $tmpdir

# Ensure latest Debian stable base image
$oci_runtime pull buildpack-deps:bullseye

# Create a machine image with all the required build tools pre-installed
$oci_runtime build -t libvips-build-win-mxe container

# Run build scripts inside a container with the:
# - current UID and GID inherited
# - build dir mounted at /data
# - temporary dir mounted at /var/tmp
$oci_runtime run --rm -t \
  -u $(id -u):$(id -g) \
  -v $PWD/build:/data \
  -v $tmpdir:/var/tmp:z \
  -e "GIT_COMMIT=$git_commit" \
  -e "HEVC=$with_hevc" \
  -e "DEBUG=$with_debug" \
  -e "LLVM=$with_llvm" \
  -e "MOZJPEG=$with_mozjpeg" \
  -e "ZLIB_NG=$with_zlib_ng" \
  libvips-build-win-mxe \
  $deps \
  $target

# Test vips utility outside the container
if [ -x "$(command -v wine)" ]; then
  echo -n "testing build ... "
  wine $PWD/build/$repackage_dir/bin/vips.exe --help > /dev/null
  if [ "$?" -ne "0" ]; then
    echo "WARNING: vips.exe failed to run"
  else
    echo "OK"
  fi
fi
