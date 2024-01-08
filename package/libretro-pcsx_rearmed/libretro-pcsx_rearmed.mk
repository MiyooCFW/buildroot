################################################################################
#
# PCSX_REARMED
#
################################################################################

# Commit of 2024/01/08
LIBRETRO_PCSX_REARMED_VERSION = 5ee1c9269d333936eba3e7e3259956f601ff5edd
LIBRETRO_PCSX_REARMED_SITE = $(call github,libretro,pcsx_rearmed,$(LIBRETRO_PCSX_REARMED_VERSION))
LIBRETRO_PCSX_REARMED_LICENSE = GPL-2.0
LIBRETRO_PCSX_REARMED_LICENSE_FILES = COPYING


define LIBRETRO_PCSX_REARMED_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" AR="$(TARGET_AR)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)" CPUFLAGS="-march=armv5tej -mtune=arm926ej-s"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_PCSX_REARMED_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/pcsx_rearmed_libretro.so \
		${BINARIES_DIR}/retroarch/cores/pcsx_rearmed_libretro.so
endef

$(eval $(generic-package))
