PKG             := rust-std-x86_64
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.59.0-x86_64-pc-windows-gnu.tar.gz.sha256
$(PKG)_VERSION  := 1.59.0
$(PKG)_CHECKSUM := d7e04234b8a31aa6e54df0d8727b55ef1b85a8389fbcd1bddb2f3eceb86feda5
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu/rust-std-x86_64-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu.tar.gz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
