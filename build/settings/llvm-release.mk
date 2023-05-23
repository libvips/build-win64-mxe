# MXE will run as many parallel jobs as there are available CPU
# cores. This variable can limit this.
#JOBS := 4

# MXE stores intermediate files in the current directory by
# default. Store them in /var/tmp instead to ensure git commands
# are no-op.
MXE_TMP := /var/tmp

# https://reproducible-builds.org/docs/source-date-epoch/
# https://github.com/libvips/build-win64-mxe/commit/96c2b87ee4b3c221773ba86c7217bd17ce69f740
export SOURCE_DATE_EPOCH := $(shell date +%s --date="Mar 21 2023 13:51:47 +0100")

# Special flags for compiler.
export CFLAGS   := -O3 -g -gcodeview -fdata-sections -ffunction-sections
export CXXFLAGS := -O3 -g -gcodeview -fdata-sections -ffunction-sections
export LDFLAGS  := -Wl,--pdb= -Wl,--gc-sections -Wl,-s

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := z
export CARGO_PROFILE_RELEASE_PANIC         := abort

# Debug info should be stored in the various PDBs, ensure we strip
# any residual debug info from the libs.
STRIP_LIB := $(true)

# Disable ccache
MXE_USE_CCACHE := $(false)
