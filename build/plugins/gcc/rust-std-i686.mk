PKG             := rust-std-i686
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.59.0-i686-pc-windows-gnu.tar.gz.sha256
$(PKG)_VERSION  := 1.59.0
$(PKG)_CHECKSUM := 669ef6b0396f41f5f1f1318478cde36ad8299c65055bb36e8b7a796f622f8a4e
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu/rust-std-i686-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-i686-pc-windows-gnu.tar.gz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
