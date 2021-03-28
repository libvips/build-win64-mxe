# MXE will run as many parallel jobs as there are
# available CPU cores. This variable can limit this.
#JOBS := 4

# Turn on debugging
#export CFLAGS   := -g
#export CXXFLAGS := -g
# Clang produces debug info in DWARF format by default.
# To debug with WinDbg (PDB format) use:
#export CFLAGS   := -g -gcodeview
#export CXXFLAGS := -g -gcodeview
#export LDFLAGS  := -Wl,-pdb=
# (see: https://github.com/mstorsjo/llvm-mingw/blob/master/README.md#pdb-support)

# Special flags for compiler.
export CFLAGS   := -O3 -flto
export CXXFLAGS := -O3 -flto
export LDFLAGS  := -flto -Wl,-s

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := s

# We need to build with unwind panic strategy as this is currently
# hard-coded in -Zbuild-std, see:
# https://github.com/rust-lang/wg-cargo-std-aware/issues/29
# TODO(kleisauke): Switch to abort once supported
export CARGO_PROFILE_RELEASE_PANIC         := unwind

# We don't need debugging symbols.
# For e.g. this commit:
# https://github.com/GNOME/librsvg/commit/8215d7f1f581f0aaa317cccc3e974c61d1a6ad84
# adds ~26 MB to the librsvg DLL if we don't install-strip it.
STRIP_LIB := $(true)

# Disable ccache
MXE_USE_CCACHE := $(false)
