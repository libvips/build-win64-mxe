# MXE will run as many parallel jobs as there are
# available CPU cores. This variable can limit this.
#DEFAULT_MAX_JOBS := 4

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
export CFLAGS   := -s -O3
export CXXFLAGS := -s -O3
export LDFLAGS  := -Wl,-s

# Special flags for Rust.
export RUSTFLAGS := -Copt-level=s -Clto=on -Ccodegen-units=1 -Cincremental=false -Cpanic=abort

# We don't need debugging symbols.
# For e.g. this commit:
# https://github.com/GNOME/librsvg/commit/8215d7f1f581f0aaa317cccc3e974c61d1a6ad84
# adds ~26 MB to the librsvg DLL if we don't install-strip it.
STRIP_LIB := $(true)

# Disable ccache
MXE_USE_CCACHE := $(false)
