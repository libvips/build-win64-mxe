PKG             := libspng
$(PKG)_WEBSITE  := https://libspng.org/
$(PKG)_DESCR    := Simple, modern libpng alternative.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.7.3
$(PKG)_CHECKSUM := a50cadbe808ffda1a7fab17d145f52a23b163f34b3eb3696c7ecb5a52340fc1d
$(PKG)_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/$(PKG)-[0-9]*.patch)))
$(PKG)_GH_CONF  := randy408/libspng/tags,v
$(PKG)_DEPS     := cc meson-wrapper zlib

define $(PKG)_BUILD
    # -Denable_opt=false is a workaround for:
    # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109504
    $(MXE_MESON_WRAPPER) \
        -Dbuild_examples=false \
        -Dstatic_zlib=$(if $(BUILD_STATIC),true,false) \
        $(if $(and $(IS_GCC),$(call seq,i686,$(PROCESSOR))), -Denable_opt=false) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
