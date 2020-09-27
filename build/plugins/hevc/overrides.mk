$(PLUGIN_HEADER)

IS_HEVC := $(true)

# Override sub-dependencies
libheif_DEPS := $(libheif_DEPS) libde265 x265
