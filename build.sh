#!/usr/bin/env bash

# exit on error
set -e

function usage()
{
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] [PKGS...]
Build Windows binaries for libvips in a container

OPTIONS:
	--help			Show the help and exit
	-t, --target <MXE_TARGET>	The binary target (this can be specified multiple times)
	-c, --commit <COMMIT>	The commit to build libvips from
	-r, --ref <REF>		The branch or tag to build libvips from
	--nightly		Build libvips from tip-of-tree (alias of -r master)
	--with-ffi-compat	Ensure compatibility with the FFI-bindings when building static binaries
	--with-hevc		Build libheif with the HEVC-related dependencies
	--with-debug		Build binaries without optimizations to improve debuggability
	--with-jpegli		Build binaries with jpegli instead of mozjpeg
	--with-jpeg-turbo	Build binaries with libjpeg-turbo instead of mozjpeg
	--without-prebuilt	Avoid using a prebuilt OCI image from GitHub Container Registry
	--without-zlib-ng	Build binaries with vanilla zlib

PKGS:
	The packages and their dependencies to build,
	    defaults to 'vips-web'

MXE_TARGET:
	The binary target,
	    defaults to building for all possible targets
	Possible values are:
	    - x86_64-w64-mingw32.shared
	    - x86_64-w64-mingw32.static
	    - i686-w64-mingw32.shared
	    - i686-w64-mingw32.static
	    - aarch64-w64-mingw32.shared
	    - aarch64-w64-mingw32.static
EOF

  if [ -n "$1" ]; then
    exit "$1"
  fi
}

# Default arguments
mxe_targets=()
git_commit=""
git_ref=""
jpeg_impl="mozjpeg"
with_ffi_compat=false
with_hevc=false
with_debug=false
with_prebuilt=true
with_zlib_ng=true

# Parse arguments
POSITIONAL=()

while [ $# -gt 0 ]; do
  case $1 in
    -h|--help) usage 0 ;;
    -t|--target) mxe_targets+=("$2"); shift ;;
    -c|--commit) git_commit="$2"; shift ;;
    -r|--ref) git_ref="$2"; shift ;;
    --nightly) git_ref="master" ;;
    --with-ffi-compat) with_ffi_compat=true ;;
    --with-hevc) with_hevc=true ;;
    --with-debug) with_debug=true ;;
    --with-jpegli) jpeg_impl="jpegli" ;;
    --with-jpeg-turbo) jpeg_impl="libjpeg-turbo" ;;
    --without-mozjpeg) jpeg_impl="libjpeg-turbo" ;; # For compat
    --without-prebuilt) with_prebuilt=false ;;
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

pkgs=("$@")

if [ ${#pkgs[@]} -eq 0 ]; then
  pkgs=(vips-web)
fi

# Note: GTK apps depends on vips-all
{ [[ ${pkgs[*]} =~ "nip4" ]] || [[ ${pkgs[*]} =~ "vipsdisp" ]]; } && build_gtk=true || build_gtk=false
[[ ${pkgs[*]} =~ "vips-all" ]] && build_all_variant=true || build_all_variant=$build_gtk
[[ ${pkgs[*]} =~ "vips-web" ]] && build_web_variant=true || build_web_variant=false

if [ ${#mxe_targets[@]} -eq 0 ]; then
  if [ "$build_all_variant" = true ]; then
    # Omit static builds by default for the "all" variant
    mxe_targets=({x86_64,i686,aarch64}-w64-mingw32.shared)
  elif [ "$with_ffi_compat" = true ]; then
    # Omit shared builds by default for the --with-ffi-compat option
    mxe_targets=({x86_64,i686,aarch64}-w64-mingw32.static)
  else
    # Default to all possible targets otherwise
    mxe_targets=({x86_64,i686,aarch64}-w64-mingw32.{shared,static})
  fi
fi

[[ ${mxe_targets[*]} =~ ".static" ]] && targets_static=true || targets_static=false
[[ ${mxe_targets[*]} =~ ".shared" ]] && targets_shared=true || targets_shared=false

if [ "$with_hevc" = true ] && [ "$build_web_variant" = true ]; then
  echo "ERROR: The HEVC-related dependencies can only be built for the \"all\" variant." >&2
  exit 1
fi

if [ "$build_web_variant" = true ] && [ "$build_all_variant" = true ]; then
  echo "ERROR: Cannot build both vips-web and vips-all simultaneously." >&2
  exit 1
fi

if [ "$targets_static" = true ] && [ "$build_all_variant" = true ]; then
  echo "ERROR: Distributing a statically linked library against GPL libraries, without releasing the code as GPL, violates the GPL license." >&2
  exit 1
fi

if [ "$targets_static" = true ] && [ "$build_gtk" = true ]; then
  echo "ERROR: GTK cannot be built as a statically linked library on Windows." >&2
  exit 1
fi

if [ "$targets_shared" = true ] && [ "$with_ffi_compat" = true ]; then
  echo "WARNING: The --with-ffi-compat option makes only sense when building static binaries." >&2
  with_ffi_compat=false
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

# Ensure separate build targets
if [ "$build_all_variant" = true ]; then
  mxe_targets=("${mxe_targets[@]/%/.all}")
fi

if [ "$with_ffi_compat" = true ]; then
  mxe_targets=("${mxe_targets[@]/%/.ffi}")
fi

if [ "$with_debug" = true ]; then
  mxe_targets=("${mxe_targets[@]/%/.debug}")
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

image="ghcr.io/libvips/build-win64-mxe:latest"

if [ "$with_prebuilt" = false ]; then
  image="libvips-build-win-mxe-base"

  # Ensure latest Debian stable base image
  $oci_runtime pull docker.io/library/buildpack-deps:bookworm

  # Bootstrap the compilers and utilities
  $oci_runtime build -t $image -f container/base.Dockerfile .
fi

# The 'plugins' variable controls which plugins are in use
plugin_dirs="plugins/llvm-mingw /data"

if [ -n "$git_commit" ]; then
  plugin_dirs+=" /data/plugins/nightly"
fi

if [ "$jpeg_impl" != "libjpeg-turbo" ]; then
  plugin_dirs+=" /data/plugins/$jpeg_impl"
fi

if [ "$build_gtk" = true ]; then
  plugin_dirs+=" /data/plugins/gtk4"
fi

if [ "$with_hevc" = true ]; then
  plugin_dirs+=" /data/plugins/hevc"
fi

if [ "$with_zlib_ng" = true ]; then
  plugin_dirs+=" /data/plugins/zlib-ng"
fi

# Avoid shipping the gettext DLL (libintl-8.dll),
# use a statically build dummy implementation instead.
# This intentionally disables the i18n features of (GNU)
# gettext, which are probably not needed within Windows.
# See:
# https://github.com/frida/proxy-libintl
# https://github.com/libvips/libvips/issues/1637
plugin_dirs+=" /data/plugins/proxy-libintl"

# Build requested packages
$oci_runtime build \
  -t libvips-build-win-mxe \
  -f container/Dockerfile \
  --build-arg BASE_IMAGE="$image" \
  --build-arg PKGS="${pkgs[*]}" \
  --build-arg MXE_TARGETS="${mxe_targets[*]}" \
  --build-arg DEBUG="$with_debug" \
  --build-arg PLUGIN_DIRS="$plugin_dirs" \
  --build-arg GIT_COMMIT="$git_commit" \
  build

# Debug logs
# docker run --rm -it --entrypoint "/bin/bash" libvips-build-win-mxe
# grep -r "with fuzz" /usr/local/mxe/log
# grep -r "(offset" /usr/local/mxe/log

# Run packaging script inside a container with the
# packaging dir mounted at /data/packaging.
$oci_runtime run --rm -t \
  -v $PWD/packaging:/data/packaging \
  -e PKGS="${pkgs[*]}" \
  -e MXE_TARGETS="${mxe_targets[*]}" \
  -e FFI_COMPAT="$with_ffi_compat" \
  -e JPEG_IMPL="$jpeg_impl" \
  -e HEVC="$with_hevc" \
  -e DEBUG="$with_debug" \
  -e ZLIB_NG="$with_zlib_ng" \
  libvips-build-win-mxe
