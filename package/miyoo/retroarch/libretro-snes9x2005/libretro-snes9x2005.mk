################################################################################
#
# SNES9X2005 / CATSFC
#
################################################################################

# Commit of 2022/07/25
LIBRETRO_SNES9X2005_VERSION = fd45b0e055bce6cff3acde77414558784e93e7d0
LIBRETRO_SNES9X2005_SITE = $(call github,libretro,snes9x2005,$(LIBRETRO_SNES9X2005_VERSION))
LIBRETRO_SNES9X2005_LICENSE = COPYRIGHT
LIBRETRO_SNES9X2005_LICENSE_FILES = copyright
LIBRETRO_SNES9X2005_NON_COMMERCIAL = y

define LIBRETRO_SNES9X2005_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) $(LIBRETRO_SNES9X2005_SUPP_CFLAGS)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO) $(LIBRETRO_SNES9X2005_SUPP_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(RETROARCH_LIBRETRO_PLATFORM)" $(LIBRETRO_SNES9X2005_SUPP_OPT) USE_BLARGG_APU=0
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_SNES9X2005_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/snes9x2005_libretro.so \
		${BINARIES_DIR}/retroarch/cores/snes9x2005_libretro.so
endef

$(eval $(generic-package))
