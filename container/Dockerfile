# Rust toolchain is needed for librsvg
FROM rust:stretch

ARG ARCH=x86_64
ARG MESON_PATCH=https://raw.githubusercontent.com/libvips/build-win64-mxe/master/8.8/meson-3939.patch

RUN apt-get update \
  && apt-get install -y \
    # http://mxe.cc/#requirements-debian
    autopoint bison flex gettext gperf intltool \ 
    libtool-bin libxml-parser-perl lzip p7zip-full \
    ruby g++-multilib libc6-dev-i386 \
    # needed when building libvips from git
    gobject-introspection gtk-doc-tools \
    # needed for Ninja and Meson
    python3-pip

# Add Windows target for cross-compilation
RUN rustup target add ${ARCH}-pc-windows-gnu

# Install Ninja and Meson
RUN pip3 install ninja meson

# TODO: Remove when https://github.com/mesonbuild/meson/pull/3939 is merged
RUN cd `python3 -c "import site; print(site.getsitepackages()[0])"` \
  && curl $MESON_PATCH | git apply -v

# The versioned build dir is mounted at /data, so this runs the build script
# in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The versioned subdirectory is mounted here
WORKDIR /data
