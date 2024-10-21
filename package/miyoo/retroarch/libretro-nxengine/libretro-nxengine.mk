################################################################################
#
# NXENGINE
#
################################################################################

# Commit of 2023/02/21
LIBRETRO_NXENGINE_VERSION = 1f371e51c7a19049e00f4364cbe9c68ca08b303a
LIBRETRO_NXENGINE_SITE = $(call github,libretro,nxengine-libretro,$(LIBRETRO_NXENGINE_VERSION))
LIBRETRO_NXENGINE_LICENSE = GPL-3.0
LIBRETRO_NXENGINE_LICENSE_FILES = nxengine/LICENSE

define LIBRETRO_NXENGINE_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_NXENGINE_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/nxengine"
	$(INSTALL) -D $(@D)/nxengine_libretro.so \
		${BINARIES_DIR}/retroarch/cores/nxengine_libretro.so
	cp -R $(@D)/datafiles/* \
		${BINARIES_DIR}/retroarch/system/nxengine
endef

$(eval $(generic-package))
