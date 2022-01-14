$(PLUGIN_HEADER)

# Nightly build, skip checksum verification
SKIP_CHECKSUM := $(true)

vips_VERSION  := $(GIT_COMMIT)
vips_GH_CONF  := libvips/libvips/branches/master
vips_SUBDIR   := libvips-libvips-$(GIT_COMMIT)
