PKG             := rust-std-x86_64
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.78.0-x86_64-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.78.0
$(PKG)_CHECKSUM := 4fe659c9928632e5a43388544504ef7e75069d7f8e4e79a45c2b18b9e9791052
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu/rust-std-x86_64-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
