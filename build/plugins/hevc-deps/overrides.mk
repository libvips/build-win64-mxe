$(PLUGIN_HEADER)

IS_HEVC := $(true)

## Update dependencies

# upstream version is 4.1
# cannot use GH_CONF:
# x265_GH_CONF  := Multicorewareinc/x265/releases
x265_VERSION  := 4.3
x265_CHECKSUM := 83c53e4c8bbb8f1e33ed59e10a7d621d1d7801ca853910c3eb41f038b8ffb121
x265_PATCHES  := $(realpath $(sort $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))/patches/x265-[0-9]*.patch)))
x265_SUBDIR   := x265_$(x265_VERSION)
x265_FILE     := x265_$(x265_VERSION).tar.gz
x265_URL      := https://github.com/Multicorewareinc/x265/releases/download/$(x265_VERSION)/$(x265_FILE)

## Override sub-dependencies

libheif_DEPS := $(libheif_DEPS) libde265 x265

## Override build scripts

# disable CLI
# build with `-DCMAKE_BUILD_TYPE=MinSizeRel`
# enable assembly and build with `-DCROSS_COMPILE_ARM64=ON` on aarch64
define x265_BUILD
    cd '$(BUILD_DIR)' && mkdir -p 10bit 12bit

    # 12 bit
    cd '$(BUILD_DIR)/12bit' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DHIGH_BIT_DEPTH=ON \
        -DEXPORT_C_API=OFF \
        -DENABLE_SHARED=OFF \
        -DENABLE_ASSEMBLY=$(if $(call seq,64,$(BITS)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DENABLE_HDR10_PLUS=ON \
        -DMAIN12=ON \
        $(if $(call seq,aarch64,$(PROCESSOR)), -DCROSS_COMPILE_ARM64=ON)

    $(MAKE) -C '$(BUILD_DIR)/12bit' -j '$(JOBS)'
    cp '$(BUILD_DIR)/12bit/libx265.a' '$(BUILD_DIR)/libx265_main12.a'

    # 10 bit
    cd '$(BUILD_DIR)/10bit' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DHIGH_BIT_DEPTH=ON \
        -DEXPORT_C_API=OFF \
        -DENABLE_SHARED=OFF \
        -DENABLE_ASSEMBLY=$(if $(call seq,64,$(BITS)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DENABLE_HDR10_PLUS=ON \
        $(if $(call seq,aarch64,$(PROCESSOR)), -DCROSS_COMPILE_ARM64=ON)

    $(MAKE) -C '$(BUILD_DIR)/10bit' -j '$(JOBS)'
    cp '$(BUILD_DIR)/10bit/libx265.a' '$(BUILD_DIR)/libx265_main10.a'

    # 8bit
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)/source' \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DHIGH_BIT_DEPTH=OFF \
        -DEXPORT_C_API=ON \
        -DENABLE_SHARED=$(CMAKE_SHARED_BOOL) \
        -DENABLE_ASSEMBLY=$(if $(call seq,64,$(BITS)),ON,OFF) \
        -DENABLE_CLI=OFF \
        -DENABLE_HDR10_PLUS=ON \
        -DEXTRA_LIB='x265_main10.a;x265_main12.a' \
        -DEXTRA_LINK_FLAGS=-L'$(BUILD_DIR)' \
        -DLINKED_10BIT=ON \
        -DLINKED_12BIT=ON \
        $(if $(call seq,aarch64,$(PROCESSOR)), -DCROSS_COMPILE_ARM64=ON)

    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(subst -,/,$(INSTALL_STRIP_LIB))

    $(if $(BUILD_SHARED), \
        rm -f '$(PREFIX)/$(TARGET)/lib/libx265.a' \
    $(else), \
        $(INSTALL) '$(BUILD_DIR)/libx265_main12.a' '$(PREFIX)/$(TARGET)/lib/libx265_main12.a'; \
        $(INSTALL) '$(BUILD_DIR)/libx265_main10.a' '$(PREFIX)/$(TARGET)/lib/libx265_main10.a'; \
        $(SED) -i 's|-lx265|-lx265 -lx265_main10 -lx265_main12|' '$(PREFIX)/$(TARGET)/lib/pkgconfig/x265.pc')
endef
