# LLVM 19.1.7
FROM docker.io/mstorsjo/llvm-mingw:20250114

# Path settings
ENV \
  RUSTUP_HOME="/usr/local/rustup" \
  CARGO_HOME="/usr/local/cargo" \
  PATH="/usr/local/cargo/bin:$PATH"

RUN \
  apt-get update && \
  apt-get install -qqy --no-install-recommends \
    # http://mxe.cc/#requirements-debian
    autoconf automake autopoint bison bzip2 flex gettext gperf g++ \
    g++-multilib intltool libc6-dev-i386 libgdk-pixbuf2.0-dev libssl-dev \
    libtool-bin libxml-parser-perl lzip make p7zip-full patch \
    python-is-python3 python3 python3-mako python3-packaging python3-tomli \
    ruby unzip xz-utils

# Rust
RUN \
  curl https://sh.rustup.rs -sSf | sh -s -- -y \
    --no-modify-path \
    --profile minimal \
    --target x86_64-pc-windows-gnullvm,i686-pc-windows-gnullvm,aarch64-pc-windows-gnullvm \
    --default-toolchain nightly-2025-01-30 \
    --component rust-src && \
  cargo install cargo-c --locked

# The build dir is mounted at /data, so this runs the build script in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The build dir is mounted here
WORKDIR /data
