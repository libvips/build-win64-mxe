PKG             := rust-std-i686
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.72.1-i686-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.72.1
$(PKG)_CHECKSUM := b55e3ef6dcd3ca2b8548c4cf4fdb1b7fd6358d959da76e2b8c92a66bf389b273
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu/rust-std-i686-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
