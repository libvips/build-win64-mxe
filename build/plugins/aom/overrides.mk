$(PLUGIN_HEADER)

IS_AOM := $(true)

# Override sub-dependencies
libheif_DEPS := $(subst dav1d rav1e,aom,$(libheif_DEPS))
