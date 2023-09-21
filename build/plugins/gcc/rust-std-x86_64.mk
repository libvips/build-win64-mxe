PKG             := rust-std-x86_64
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.72.1-x86_64-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.72.1
$(PKG)_CHECKSUM := 3d3ea3e43b3bbe0cfb30e7115f198d2e7e55f317a506b22ae16c6c145d9b89fe
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu/rust-std-x86_64-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
