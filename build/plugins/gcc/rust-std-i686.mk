PKG             := rust-std-i686
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.69.0-i686-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.69.0
$(PKG)_CHECKSUM := 5eb9bf9ca715cf97d4e6819312e08b1038b8e90cfb8e63e9df57b93b74c48521
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu/rust-std-i686-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
