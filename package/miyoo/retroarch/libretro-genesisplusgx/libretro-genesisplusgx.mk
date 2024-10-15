################################################################################
#
# GENESIS-PLUS-GX
#
################################################################################

# Commit of 2023/10/06
LIBRETRO_GENESISPLUSGX_VERSION = 8d644682b6a88d662d1a07e063fa863633a99311
LIBRETRO_GENESISPLUSGX_SITE = $(call github,libretro,Genesis-Plus-GX,$(LIBRETRO_GENESISPLUSGX_VERSION))
LIBRETRO_GENESISPLUSGX_LICENSE = COPYRIGHT
LIBRETRO_GENESISPLUSGX_LICENSE_FILES = LICENSE.txt
LIBRETRO_GENESISPLUSGX_NON_COMMERCIAL = y

define LIBRETRO_GENESISPLUSGX_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_GENESISPLUSGX_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/genesis_plus_gx_libretro.so \
		${BINARIES_DIR}/retroarch/cores/genesisplusgx_libretro.so
endef

$(eval $(generic-package))
