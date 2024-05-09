PKG             := rust-std-i686
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.78.0-i686-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.78.0
$(PKG)_CHECKSUM := f1a0fc747ef54e7827e77cb9a4acaae5078c632dfeeb1a5d0cf8fa2272fca70f
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu/rust-std-i686-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
