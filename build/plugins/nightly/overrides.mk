$(PLUGIN_HEADER)

# Nightly build, skip checksum verification
SKIP_CHECKSUM := $(true)

vips-web_VERSION  := $(NIGHTLY_VERSION)
vips-web_GH_CONF  := libvips/libvips/branches/master
vips-web_SUBDIR   := libvips-libvips-$(NIGHTLY_VERSION)
vips-web_FILE     := vips-web-$(NIGHTLY_VERSION).tar.gz

vips-web_BUILD_x86_64-w64-mingw32  = $(subst configure,autogen.sh,$(vips-web_BUILD))
vips-web_BUILD_i686-w64-mingw32    = $(subst configure,autogen.sh,$(vips-web_BUILD))
vips-web_BUILD_aarch64-w64-mingw32 = $(subst configure,autogen.sh,$(vips-web_BUILD))
vips-web_BUILD_armv7-w64-mingw32   = $(subst configure,autogen.sh,$(vips-web_BUILD))

vips-all_VERSION  := $(NIGHTLY_VERSION)
vips-all_GH_CONF  := libvips/libvips/branches/master
vips-all_SUBDIR   := libvips-libvips-$(NIGHTLY_VERSION)
vips-all_FILE     := vips-all-$(NIGHTLY_VERSION).tar.gz

vips-all_BUILD_x86_64-w64-mingw32  = $(subst configure,autogen.sh,$(vips-all_BUILD))
vips-all_BUILD_i686-w64-mingw32    = $(subst configure,autogen.sh,$(vips-all_BUILD))
vips-all_BUILD_aarch64-w64-mingw32 = $(subst configure,autogen.sh,$(vips-all_BUILD))
vips-all_BUILD_armv7-w64-mingw32   = $(subst configure,autogen.sh,$(vips-all_BUILD))
