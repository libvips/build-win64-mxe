$(PLUGIN_HEADER)

# The `-Wl,-Xlink=-force:multiple` linker
# flag is a workaround for:
# https://github.com/rust-lang/rust/issues/44322
vips_MESON_OPTS = \
    -Dmodules=disabled \
    -Dcfitsio=disabled \
    -Dfftw=disabled \
    -Djpeg-xl=disabled \
    -Dmagick=disabled \
    -Dmatio=disabled \
    -Dnifti=disabled \
    -Dopenexr=disabled \
    -Dopenjpeg=disabled \
    -Dopenslide=disabled \
    -Dpdfium=disabled \
    -Dpoppler=disabled \
    -Dquantizr=disabled \
    -Draw=disabled \
    -Dppm=false \
    -Danalyze=false \
    -Dradiance=false \
    $(if $(BUILD_STATIC), -Dcpp_link_args="$(LDFLAGS) -Wl$(comma)-Xlink=-force:multiple")
