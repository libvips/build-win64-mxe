## TODO
- [ ] Try to build the libvips gtk-docs, see this attempt (fails because it tries to build `libvips-scan` with the MinGW compiler):
  ```
  # Symlink gtk-doc to MXE:
  ln -sf /usr/share/aclocal/gtk-doc.m4 $(PREFIX)/$(TARGET)/share/aclocal/
  ln -sf /usr/share/pkgconfig/gtk-doc.pc $(PREFIX)/$(TARGET)/lib/pkgconfig/
  ln -sf /usr/bin/gtkdoc* $(PREFIX)/$(TARGET)/bin/
  # Enable gtk-doc:
  $(filter-out --enable-gtk-doc=no \\, \
  $(filter-out --enable-gtk-doc-html=no \\, \
  $(MXE_CONFIGURE_OPTS))) \
  --enable-gtk-doc=yes \
  --docdir='$(SOURCE_DIR)/doc' \
  --with-html-dir='$(PREFIX)/$(TARGET)/share/gtk-doc/html' \
  ```
- [ ] Let Travis build libvips with pre-compiled dependencies.
  - [ ] Wait for: https://github.com/mxe/mxe/issues/2021.
- [ ] Incorporate all new dependencies and patches into [MXE](https://github.com/mxe/mxe).
  - [ ] Should we also add libvips-web?
  - [ ] Not sure about `librsvg`, because v2.42.0+ requires the Rust toolchain.
- [ ] Try to test the binaries with the Python test suite on Wine.
- [ ] Remove `meson-3939.patch` when [PR #3939](https://github.com/mesonbuild/meson/pull/3939) is merged.
