# MXE will run as many parallel jobs as there are available CPU
# cores. This variable can limit this.
#JOBS := 4

# MXE stores intermediate files in the current directory by
# default. Store them in /var/tmp instead to ensure git commands
# are no-op.
MXE_TMP := /var/tmp

# Turn on debugging
export CFLAGS   := -g -Og -fPIC
export CXXFLAGS := -g -Og -fPIC

# GCC doesn't support generating debug info in the PDB format,
# use https://github.com/rainers/cv2pdb as workaround, e.g.:
#   for /r %i in (*.exe *.dll) do cv2pdb %i

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := true
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := 1
export CARGO_PROFILE_RELEASE_PANIC         := abort

# We need debugging symbols.
STRIP_TOOLCHAIN := $(false)
STRIP_LIB       := $(false)
STRIP_EXE       := $(false)

# Disable ccache
MXE_USE_CCACHE := $(false)
