################################################################################
#
# VEMULATOR
#
################################################################################

LIBRETRO_VEMULATOR_VERSION = ff9c39714fe64960b4050c6884c70c24e63de4fd
LIBRETRO_VEMULATOR_SITE = $(call github,libretro,vemulator-libretro,$(LIBRETRO_VEMULATOR_VERSION))
LIBRETRO_VEMULATOR_LICENSE = GPL-3.0
LIBRETRO_VEMULATOR_LICENSE_FILES = COPYING

define LIBRETRO_VEMULATOR_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_VEMULATOR_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/vemulator_libretro.so \
		${BINARIES_DIR}/retroarch/cores/vemulator_libretro.so
endef

$(eval $(generic-package))
