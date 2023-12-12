$(PLUGIN_HEADER)

IS_INTL_DUMMY := $(true)

# Override sub-dependencies
glib_DEPS := $(subst gettext,proxy-libintl,$(glib_DEPS))

# Disable the gettext build, just to be sure
gettext_BUILD_x86_64-w64-mingw32  =
gettext_BUILD_i686-w64-mingw32    =
gettext_BUILD_aarch64-w64-mingw32 =
