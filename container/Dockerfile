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
RUN cd $(dirname `python3 -c "import mesonbuild as _; print(_.__path__[0])"`) \
  && curl -L https://gist.github.com/kleisauke/a2370bf67d1d8813cf8257c039488a79/raw/c99122daaee097430aef0df88b87d449a0b36999/meson-llvm-mingw.patch | git apply -v

ARG ARCH=x86_64

# Add Windows target for cross-compilation
# TODO: the armv7-pc-windows-gnu and aarch64-pc-windows-gnu Rust targets are not yet supported
RUN if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "i686" ]; then rustup target add $ARCH-pc-windows-gnu; else echo Rust MinGW target CPU architecture $ARCH is not supported; fi

# gas-preprocessor.pl is required for the ARM/ARM64 builds of libjpeg-turbo
RUN curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl -o /usr/bin/gas-preprocessor.pl \
  && chmod +x /usr/bin/gas-preprocessor.pl

# The versioned build dir is mounted at /data, so this runs the build script
# in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The versioned subdirectory is mounted here
WORKDIR /data
