$(PLUGIN_HEADER)

IS_LLVM := $(true)

# Override sub-dependencies
cc_DEPS := llvm

# libc++ uses Win32 threads to implement the internal
# threading API, so we do not need to build pthreads.
define pthreads_BUILD
    $(info $(PKG) is not built when the llvm-mingw plugin is used)
endef
