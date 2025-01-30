# LLVM 20.1.0
FROM docker.io/mstorsjo/llvm-mingw:20250305

# Path settings
ENV \
  RUSTUP_HOME="/usr/local/rustup" \
  CARGO_HOME="/usr/local/cargo" \
  PATH="/usr/local/cargo/bin:$PATH"

RUN \
  apt-get update && \
  apt-get install -qqy --no-install-recommends \
    # http://mxe.cc/#requirements-debian
    autoconf bison flex gperf intltool libgdk-pixbuf2.0-dev \
    libssl-dev libtool-bin libxml-parser-perl lzip p7zip-full \
    python-is-python3 python3-mako python3-packaging python3-tomli \
    ruby

# Rust
RUN \
  curl https://sh.rustup.rs -sSf | sh -s -- -y \
    --no-modify-path \
    --profile minimal \
    --target x86_64-pc-windows-gnullvm,i686-pc-windows-gnullvm,aarch64-pc-windows-gnullvm \
    --default-toolchain nightly-2025-03-05 \
    --component rust-src && \
  cargo install cargo-c --locked

# The build dir is mounted at /data, so this runs the build script in that
ENTRYPOINT ["/bin/bash", "/data/build.sh"]

# The build dir is mounted here
WORKDIR /data
