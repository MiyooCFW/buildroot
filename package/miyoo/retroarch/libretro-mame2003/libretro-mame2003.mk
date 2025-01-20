################################################################################
#
# MAME2003
#
################################################################################

# Commit of Dec 10, 2024
LIBRETRO_MAME2003_VERSION = b6c6d52d8d630d1a172b6b771443dcbbdb45b76d
LIBRETRO_MAME2003_SITE = $(call github,libretro,mame2003-libretro,$(LIBRETRO_MAME2003_VERSION))
LIBRETRO_MAME2003_LICENSE = MAME
LIBRETRO_MAME2003_LICENSE_FILES = LICENSE.md
LIBRETRO_MAME2003_NON_COMMERCIAL = y


define LIBRETRO_MAME2003_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	mkdir -p $(@D)/obj/mame/cpu/ccpu
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MAME2003_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/mame2003"
	$(INSTALL) -D $(@D)/mame2003_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mame2003_libretro.so
	$(INSTALL) -D $(@D)/metadata/* \
		${BINARIES_DIR}/retroarch/system/mame2003
endef

$(eval $(generic-package))
