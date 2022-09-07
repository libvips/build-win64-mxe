PKG             := rust-std-x86_64
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.63.0-x86_64-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.63.0
$(PKG)_CHECKSUM := ff44c19a81cdd8487d46584238de2a45cf8129dc38569e95fac1ab704a860bac
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu/rust-std-x86_64-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
