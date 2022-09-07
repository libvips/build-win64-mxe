PKG             := rust-std-i686
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.63.0-i686-pc-windows-gnu.tar.xz.sha256
$(PKG)_VERSION  := 1.63.0
$(PKG)_CHECKSUM := 54f6fad9a298b5920cefbbd9aba6111e058a462bd14e67f6bdebcda95f1dde4e
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu/rust-std-i686-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu.tar.xz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
