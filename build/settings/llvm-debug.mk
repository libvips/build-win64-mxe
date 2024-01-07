# MXE will run as many parallel jobs as there are available CPU
# cores. This variable can limit this.
#JOBS := 4

# MXE stores intermediate files in the current directory by
# default. Store them in /var/tmp instead to ensure git commands
# are no-op.
MXE_TMP := /var/tmp

# Disable optimizations to improve debuggability.
export CFLAGS   := -g -gcodeview -Og -fdata-sections -ffunction-sections
export CXXFLAGS := -g -gcodeview -Og -fdata-sections -ffunction-sections
export LDFLAGS  := -Wl,--pdb= -Wl,--gc-sections

# Special flags for Rust.
export CARGO_PROFILE_RELEASE_DEBUG         := true
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS := 1
export CARGO_PROFILE_RELEASE_INCREMENTAL   := false
# Temporarily disabled due to https://github.com/rust-lang/rust/issues/118609#issuecomment-1859245254
#export CARGO_PROFILE_RELEASE_LTO           := true
export CARGO_PROFILE_RELEASE_OPT_LEVEL     := 1
export CARGO_PROFILE_RELEASE_PANIC         := abort

# Avoid stripping.
STRIP_TOOLCHAIN := $(false)
STRIP_LIB       := $(false)
STRIP_EXE       := $(false)

# Disable ccache
MXE_USE_CCACHE := $(false)
