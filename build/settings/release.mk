# MXE will run as many parallel jobs as there are available CPU
# cores. This variable can limit this.
#JOBS := 4

# Print the complete log if the build or download fails.
MXE_VERBOSE := true

# MXE stores intermediate files in the current directory by
# default. Store them in /var/tmp instead to ensure git commands
# are no-op.
MXE_TMP := /var/tmp

# Special flags for compiler.
# Default optimisation level is for binary size (-Os).
# Overridden to performance (-O3) for select dependencies that benefit.
TARGET_CFLAGS   := -Os -g -gcodeview -fdata-sections -ffunction-sections
TARGET_CXXFLAGS := -Os -g -gcodeview -fdata-sections -ffunction-sections
TARGET_LDFLAGS  := -Wl,--pdb= -Wl,--gc-sections -Wl,-s

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := z
export CARGO_PROFILE_RELEASE_PANIC         := abort

# Install the various PDBs.
INSTALL_PDB := $(true)

# Debug info should be stored in the various PDBs, ensure we strip
# any residual debug info from the libs.
STRIP_LIB := $(true)

# Disable ccache.
MXE_USE_CCACHE := $(false)
