################################################################################
#
# GPSP
#
################################################################################

# Commit of 2023/10/06
LIBRETRO_GPSP_VERSION = eaf8b94702c5ded2fe3a3fc6a7f9718652fe8595
LIBRETRO_GPSP_SITE = $(call github,libretro,gpsp,$(LIBRETRO_GPSP_VERSION))
LIBRETRO_GPSP_LICENSE = GPL-2.0
LIBRETRO_GPSP_LICENSE_FILES = COPYING

define LIBRETRO_GPSP_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(RETROARCH_LIBRETRO_PLATFORM)" OPTIMIZE="$(COMPILER_COMMONS_LDFLAGS_SO)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_GPSP_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system"
	$(INSTALL) -D $(@D)/gpsp_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gpsp_libretro.so
	$(INSTALL) -D $(@D)/bios/open_gba_bios.bin \
		${BINARIES_DIR}/retroarch/system
endef

$(eval $(generic-package))
