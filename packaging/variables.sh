# included by packaging scripts

# build-win64-mxe/packaging dir we are building
work_dir=$(pwd)

# MXE specific
mxe_dir=/usr/local/mxe
mxe_prefix=$mxe_dir/usr

# Remove patch version component
without_patch() {
  echo "${1%.[[:digit:]]*}"
}

# Whitelist the API set DLLs
# Can't do api-ms-win-crt-*-l1-1-0.dll, unfortunately
whitelist=(api-ms-win-crt-{conio,convert,environment,filesystem,heap,locale,math,multibyte,private,process,runtime,stdio,string,time,utility}-l1-1-0.dll)

# Whitelist bcryptprimitives.dll for Rust
# See: https://github.com/rust-lang/rust/pull/84096
whitelist+=(bcryptprimitives.dll)

# Whitelist ntdll.dll for Rust
# See: https://github.com/rust-lang/rust/pull/108262
whitelist+=(ntdll.dll)

# Whitelist api-ms-win-core-synch-l1-2-0.dll for Rust
# See: https://github.com/rust-lang/rust/pull/121317
whitelist+=(api-ms-win-core-synch-l1-2-0.dll)
