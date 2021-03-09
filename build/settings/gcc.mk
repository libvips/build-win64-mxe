# MXE will run as many parallel jobs as there are
# available CPU cores. This variable can limit this.
#JOBS := 4

# Turn on debugging
#export CFLAGS   := -g
#export CXXFLAGS := -g
# GCC doesn't support generating debug info in the PDB format,
# use https://github.com/rainers/cv2pdb as workaround, e.g.:
#   for /r %i in (*.exe *.dll) do cv2pdb %i

# Special flags for compiler.
export CFLAGS   := -s -O3 -fPIC
export CXXFLAGS := -s -O3 -fPIC
export LDFLAGS  := -Wl,-s

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := s
export CARGO_PROFILE_RELEASE_PANIC         := abort

# We don't need debugging symbols.
# For e.g. this commit:
# https://github.com/GNOME/librsvg/commit/8215d7f1f581f0aaa317cccc3e974c61d1a6ad84
# adds ~26 MB to the librsvg DLL if we don't install-strip it.
STRIP_LIB := $(true)

# Disable ccache
MXE_USE_CCACHE := $(false)
