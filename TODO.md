## TODO
- [ ] Add CI that builds libvips with pre-compiled dependencies.
  - [ ] Wait for: [mxe/mxe#2021](https://github.com/mxe/mxe/issues/2021).
- [ ] Incorporate all new dependencies and patches into [MXE](https://github.com/mxe/mxe).
  - [ ] Should we also add libvips-web?
  - [x] Not sure about `librsvg`, because v2.42.0+ requires the Rust toolchain.
- [x] Try to test the binaries with the Python test suite on Wine.
- [ ] Incorporate the llvm-mingw toolchain plugin into MXE (see [mxe/mxe#2330](https://github.com/mxe/mxe/issues/2330)).
  - [x] Test the `armv7-w64-mingw32` target on a Raspberry Pi 3B with Windows 10 IoT.
  - [x] Test the `aarch64-w64-mingw32` target on a Raspberry Pi 4B with Windows 10 ARM64.
  - [x] The libvips test suite should be able to run successfully on ARM/ARM64.
  - [ ] Fix the llvm-mingw specific patches upstream or within LLVM.
  - [x] The Rust MinGW-w64 ARM/ARM64 targets are not yet supported, is there an alternative way to build librsvg for these architectures?
