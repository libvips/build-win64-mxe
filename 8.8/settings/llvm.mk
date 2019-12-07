# This variable controls the number of compilation processes
# within one package ("intra-package parallelism").
JOBS := 4

# Turn on debugging (see also mxe-crossfile.meson.in)
#export CFLAGS   := -g
#export CXXFLAGS := -g
# Clang produces debug info in DWARF format by default.
# To debug with WinDbg (PDB format) use:
#export CFLAGS   := -g -gcodeview
#export CXXFLAGS := -g -gcodeview
#export LDFLAGS  := -Wl,-pdb=
# (see: https://github.com/mstorsjo/llvm-mingw/blob/master/README.md#pdb-support)

# Special flags for compiler.
export CFLAGS   := -s -O3 -ffast-math
export CXXFLAGS := -s -O3 -ffast-math
export LDFLAGS  := -Wl,-s

# Environment variables needed by Rust.
#export RUSTUP_HOME := /home/kleisauke/.rustup
#export CARGO_HOME  := /home/kleisauke/.cargo
#export PATH        := /home/kleisauke/.cargo/bin:$(PATH)
export RUSTUP_HOME := /usr/local/rustup
export RUSTFLAGS   := -C panic=abort
export CARGO_HOME  := /usr/local/cargo
export PATH        := /usr/local/cargo/bin:$(PATH)

# We don't need debugging symbols.
# For e.g. this commit:
# https://github.com/GNOME/librsvg/commit/8215d7f1f581f0aaa317cccc3e974c61d1a6ad84
# adds ~26 MB to the librsvg DLL if we don't install-strip it.
STRIP_LIB := $(true)

# Disable ccache, it won't work with llvm-mingw
MXE_USE_CCACHE := $(false)
