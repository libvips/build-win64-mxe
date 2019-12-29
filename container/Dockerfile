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

# TODO: Remove when https://github.com/mesonbuild/meson/pull/5912 is merged
RUN cd `python3 -c "import site; print(site.getsitepackages()[0])"` \
  && curl https://patch-diff.githubusercontent.com/raw/mesonbuild/meson/pull/5912.patch | git apply -v \
  && curl https://gist.githubusercontent.com/kleisauke/a2370bf67d1d8813cf8257c039488a79/raw/9b91bc3d3cd8244fb6c46c710cd85af080cbb166/meson.patch | git apply -v

ARG ARCH=x86_64

# Add Windows target for cross-compilation
RUN rustup target add $ARCH-pc-windows-gnu

# The versioned build dir is mounted at /data, so this runs the build script
# in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The versioned subdirectory is mounted here
WORKDIR /data
