FROM docker.io/library/buildpack-deps:trixie

RUN \
  apt-get update && \
  apt-get install -qqy --no-install-recommends \
    # http://mxe.cc/#requirements-debian
    autopoint bison build-essential flex gettext gperf \
    intltool jq libtool-bin libxml-parser-perl lzip p7zip-full \
    python-is-python3 python3-mako ruby zip \
    # needed by adwaita-icon-theme
    gtk-update-icon-cache

WORKDIR /usr/local
RUN git clone -b llvm-mingw-20251119 --single-branch https://github.com/kleisauke/mxe.git

WORKDIR /usr/local/mxe

# Bootstrap compilers and utilities
RUN --mount=type=cache,id=mxe-download,target=/usr/local/mxe/pkg \
  echo "MXE_TARGETS := x86_64-pc-linux-gnu" > settings.mk && \
  make autotools cargo-c cc meson nasm pe-util \
    MXE_VERBOSE=true \
    MXE_TMP="/var/tmp" \
    MXE_PLUGIN_DIRS="plugins/llvm-mingw" \
    MXE_USE_CCACHE=
