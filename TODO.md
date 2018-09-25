## TODO
- [X] Add headers, link libraries and def files to the `-dev` packages.
  - [X] For NetVips this isn't necessary, so make a `-slim` package which contains only runtime DDLs and relevant EXEs.
  - [X] `libvipsCC-42.dll` and `libvips-cpp-42.dll` also needs to be added.
  - [X] `AUTHORS`, `ChangeLog`, `COPYING` and `README.md` also needs to be added.
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
- [X] Try to build with [orc](https://github.com/GStreamer/orc).
- [X] Add [cfitsio](https://heasarc.gsfc.nasa.gov/fitsio/) to the 'all target'. MXE already has [this dependency](https://github.com/mxe/mxe/blob/master/src/cfitsio.mk).
- [X] Add [OpenEXR](https://github.com/openexr/openexr) to the 'all target'. MXE already has [this dependency](https://github.com/mxe/mxe/blob/master/src/openexr.mk).
- [X] Add [nifticlib](https://nifti.nimh.nih.gov/) to the 'all target'.
- [X] Try to update ImageMagick6 to the latest version (latest versions of ImageMagick are continuous fuzzed by [OSS-Fuzz](https://github.com/google/oss-fuzz), so it'll reduce the attack surface).
- [ ] Let Travis build libvips with pre-compiled dependencies.
  - [ ] Wait for: https://github.com/mxe/mxe/issues/2021.
- [ ] Incorporate all new dependencies and patches into [MXE](https://github.com/mxe/mxe).
  - [ ] Should we also add libvips-web?
  - [ ] Not sure about `librsvg`, because v2.42.0+ requires the Rust toolchain.
- [X] Try to update Pixman to 0.34.0. Couldn't find a tarball for version 0.34.0 [here](https://cairographics.org/snapshots/).
- [X] Try to build with 32-bit architecture (not sure if this is still being distributed).
- [ ] Try to test the binaries with the Python test suite on Wine.
