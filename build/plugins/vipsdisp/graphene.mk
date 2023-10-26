PKG             := graphene
$(PKG)_WEBSITE  := https://github.com/ebassi/graphene
$(PKG)_DESCR    := A thin layer of graphic data types 
$(PKG)_IGNORE   :=
# https://github.com/ebassi/graphene/tarball/0cfa05ff62f244e4d5e7ac35a1979a23f25c5151
$(PKG)_VERSION  := 0cfa05f
$(PKG)_CHECKSUM := ea56afe5d9f90c5ead9cba4be117b6a75db68ab4da3940569dc2c747b791fe66
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
