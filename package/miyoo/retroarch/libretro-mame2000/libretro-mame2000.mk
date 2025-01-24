################################################################################
#
# MAME2000 / IMAME
#
################################################################################

# Commit of Jul 1, 2024
LIBRETRO_MAME2000_VERSION = 2ec60f6e1078cf9ba173e80432cc28fd4eea200f
LIBRETRO_MAME2000_SITE = $(call github,libretro,mame2000-libretro,$(LIBRETRO_MAME2000_VERSION))
LIBRETRO_MAME2000_LICENSE = MAME
LIBRETRO_MAME2000_LICENSE_FILES = readme.txt
LIBRETRO_MAME2000_NON_COMMERCIAL = y


define LIBRETRO_MAME2000_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	mkdir -p $(@D)/obj_libretro_libretro/cpu
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MAME2000_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/mame2000"
	$(INSTALL) -D $(@D)/mame2000_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mame2000_libretro.so
	$(INSTALL) -D $(@D)/metadata/* \
		${BINARIES_DIR}/retroarch/system/mame2000
endef

$(eval $(generic-package))
