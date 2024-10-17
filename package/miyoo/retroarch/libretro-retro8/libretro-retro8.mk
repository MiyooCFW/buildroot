################################################################################
#
# RETRO8
#
################################################################################

LIBRETRO_RETRO8_VERSION = bc388ec7d217a08265d116aaa74afc0ca3f204f5
LIBRETRO_RETRO8_SITE = $(call github,libretro,retro8,$(LIBRETRO_RETRO8_VERSION))
LIBRETRO_RETRO8_LICENSE = GPL-3.0
LIBRETRO_RETRO8_LICENSE_FILES = LICENSE

define LIBRETRO_RETRO8_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_RETRO8_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/retro8_libretro.so \
		${BINARIES_DIR}/retroarch/cores/retro8_libretro.so
endef

$(eval $(generic-package))
