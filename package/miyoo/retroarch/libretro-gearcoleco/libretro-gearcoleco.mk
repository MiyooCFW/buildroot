################################################################################
#
# GEARCOLECO
#
################################################################################

# Commit of 2023/08/23
LIBRETRO_GEARCOLECO_VERSION = cc7c19c776a12d149c2c935e2198ddad15f22f54
LIBRETRO_GEARCOLECO_SITE = $(call github,drhelius,Gearcoleco,$(LIBRETRO_GEARCOLECO_VERSION))
LIBRETRO_GEARCOLECO_LICENSE = GPL-3.0
LIBRETRO_GEARCOLECO_LICENSE_FILES = LICENSE
LIBRETRO_GEARCOLECO_NON_COMMERCIAL = NO

define LIBRETRO_GEARCOLECO_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/platforms/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platforms/libretro -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/platforms/libretro/*_libretro.so
endef

define LIBRETRO_GEARCOLECO_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/platforms/libretro/gearcoleco_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gearcoleco_libretro.so
endef

$(eval $(generic-package))
