$(PLUGIN_HEADER)

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
    -Dradiance=false
