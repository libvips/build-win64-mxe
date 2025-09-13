$(PLUGIN_HEADER)

# Patch to build gio and gmodule statically
glib_PATCHES := $(glib_PATCHES) \
                $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/glib-[0-9]*.patch)))

# Build as shared library when `--with-ffi-compat` is passed, since we
# need `libgobject-2.0-0.dll` and `libglib-2.0-0.dll` for these bindings.
glib_MESON_OPTS = --default-library=shared
