PKG             := rust-std-x86_64
$(PKG)_WEBSITE  := https://www.rust-lang.org/
$(PKG)_DESCR    := A systems programming language focused on safety, speed and concurrency.
$(PKG)_IGNORE   :=
# https://static.rust-lang.org/dist/rust-1.54.0-x86_64-pc-windows-gnu.tar.gz.sha256
$(PKG)_VERSION  := 1.54.0
$(PKG)_CHECKSUM := f8b9b2befdf71626c44957c3467aa00e300696e579a8c6d368cb739adc8776e3
$(PKG)_SUBDIR   := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu/rust-std-x86_64-pc-windows-gnu
$(PKG)_FILE     := rust-$($(PKG)_VERSION)-x86_64-pc-windows-gnu.tar.gz
$(PKG)_URL      := https://static.rust-lang.org/dist/$($(PKG)_FILE)
$(PKG)_TYPE     := source-only
