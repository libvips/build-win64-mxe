$(PLUGIN_HEADER)

IS_LLVM := $(true)

# [major].[minor].[patch]-[label] -> [major].[minor].[patch]
#clang_VERSION := $(firstword $(subst -, ,$(llvm_VERSION)))
clang_VERSION := 14.0.4

# Override sub-dependencies
cc_DEPS := llvm

# libc++ uses Win32 threads to implement the internal
# threading API, so we do not need to build pthreads.
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
