PKG             := graphene
$(PKG)_WEBSITE  := https://github.com/ebassi/graphene
$(PKG)_DESCR    := A thin layer of graphic data types
$(PKG)_IGNORE   :=
# https://github.com/ebassi/graphene/tarball/98173e59a3d80d3dd5ad6e4eaab919b4649ac7e5
$(PKG)_VERSION  := 98173e5
$(PKG)_CHECKSUM := 2b122352dda3f68d5d561a9b628bc9ac6c0ccc7af044e6c8fa9fdd496f98def2
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := ebassi/graphene/branches/master
$(PKG)_DEPS     := cc meson-wrapper glib

# Build from the master branch for https://github.com/ebassi/graphene/commit/1a4430f448e0fcc8188cfe9323f1a688d0486eae
define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) \
        -Dintrospection=disabled \
        -Dtests=false \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
