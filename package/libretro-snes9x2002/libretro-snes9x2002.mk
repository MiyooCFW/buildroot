################################################################################
#
# SNES9X2002 / POCKETSNES
#
################################################################################

# Commit of 2022/08/06
LIBRETRO_SNES9X2002_VERSION = 540baad622d9833bba7e0696193cb06f5f02f564
LIBRETRO_SNES9X2002_SITE = $(call github,libretro,snes9x2002,$(LIBRETRO_SNES9X2002_VERSION))
LIBRETRO_SNES9X2002_LICENSE = COPYRIGHT
LIBRETRO_SNES9X2002_NON_COMMERCIAL = y

# Dynarec on all boards
#LIBRETRO_SNES9X2002_SUPP_OPT=USE_DYNAREC=1

#LIBRETRO_SNES9X2002_SUPP_OPT+=ARM_ASM=1
#LIBRETRO_SNES9X2002_SUPP_CFLAGS+=-Wa,-mimplicit-it=thumb

define LIBRETRO_SNES9X2002_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) $(LIBRETRO_SNES9X2002_SUPP_CFLAGS)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) $(LIBRETRO_SNES9X2002_SUPP_OPT) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_SNES9X2002_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/snes9x2002_libretro.so \
		${BINARIES_DIR}/retroarch/cores/snes9x2002_libretro.so
endef

$(eval $(generic-package))
