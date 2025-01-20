################################################################################
#
# MAME2003_PLUS
#
################################################################################

# Commit of Jan 19, 2025 - don't forget to regenerate arcade-dats flats file
LIBRETRO_MAME2003_PLUS_VERSION = 0fcccae96eb722d58be329977eb49173c5c97981
LIBRETRO_MAME2003_PLUS_SITE = $(call github,libretro,mame2003-plus-libretro,$(LIBRETRO_MAME2003_PLUS_VERSION))
LIBRETRO_MAME2003_PLUS_LICENSE = MAME
LIBRETRO_MAME2003_PLUS_LICENSE_FILES = LICENSE.md
LIBRETRO_MAME2003_PLUS_NON_COMMERCIAL = y

define LIBRETRO_MAME2003_PLUS_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	mkdir -p $(@D)/obj/mame/cpu/ccpu
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MAME2003_PLUS_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/mame2003-plus"
	$(INSTALL) -D $(@D)/mame2003_plus_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mame2003_plus_libretro.so
	cp -R $(@D)/metadata/* \
		${BINARIES_DIR}/retroarch/system/mame2003-plus
endef

$(eval $(generic-package))
