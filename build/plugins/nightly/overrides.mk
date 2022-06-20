$(PLUGIN_HEADER)

# Nightly build, skip checksum verification
SKIP_CHECKSUM := $(true)

vips-web_VERSION  := $(GIT_COMMIT)
vips-web_GH_CONF  := libvips/libvips/branches/master
vips-web_SUBDIR   := libvips-libvips-$(GIT_COMMIT)
vips-web_FILE     := vips-web-$(GIT_COMMIT).tar.gz

vips-all_VERSION  := $(GIT_COMMIT)
vips-all_GH_CONF  := libvips/libvips/branches/master
vips-all_SUBDIR   := libvips-libvips-$(GIT_COMMIT)
vips-all_FILE     := vips-all-$(GIT_COMMIT).tar.gz
