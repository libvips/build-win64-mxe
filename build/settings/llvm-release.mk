# MXE will run as many parallel jobs as there are available CPU
# cores. This variable can limit this.
#JOBS := 4

# MXE stores intermediate files in the current directory by
# default. Store them in /var/tmp instead to ensure git commands
# are no-op.
MXE_TMP := /var/tmp

# Special flags for compiler.
# Default optimisation level is for binary size (-Os).
# Overriden to performance (-O3) for select dependencies that benefit.
export CFLAGS   := -Os -g -gcodeview -fdata-sections -ffunction-sections
export CXXFLAGS := -Os -g -gcodeview -fdata-sections -ffunction-sections
export LDFLAGS  := -Wl,--pdb= -Wl,--gc-sections -Wl,-s

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
# Temporarily disabled due to https://github.com/rust-lang/rust/issues/118609#issuecomment-1859245254
#export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := z
export CARGO_PROFILE_RELEASE_PANIC         := abort

# Debug info should be stored in the various PDBs, ensure we strip
# any residual debug info from the libs.
STRIP_LIB := $(true)

# Disable ccache
MXE_USE_CCACHE := $(false)
