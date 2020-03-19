# Rust toolchain is needed for librsvg
FROM rust:stretch

RUN apt-get update \
  && apt-get install -y \
    # http://mxe.cc/#requirements-debian
    autopoint bison flex gettext gperf intltool \ 
    libtool-bin libxml-parser-perl lzip p7zip-full \
    ruby g++-multilib libc6-dev-i386 \
    # needed when building libvips from git
    gobject-introspection gtk-doc-tools \
    # needed for Meson
    ninja-build python3-pip

# Install Ninja and Meson
RUN pip3 install meson

# TODO: This patch needs to be incorporated upstream
RUN cd $(dirname `python3 -c "import mesonbuild as _; print(_.__path__[0])"`) \
  && curl -L https://gist.github.com/kleisauke/a2370bf67d1d8813cf8257c039488a79/raw/4c21efb83c005df61f91cd51ddefdb145d9afa76/meson-llvm-mingw.patch | git apply -v

ARG ARCH=x86_64

# Add Windows target for cross-compilation
RUN rustup target add $ARCH-pc-windows-gnu

# The versioned build dir is mounted at /data, so this runs the build script
# in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The versioned subdirectory is mounted here
WORKDIR /data
