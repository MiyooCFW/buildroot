################################################################################
#
# DINOTHAWR
#
################################################################################

LIBRETRO_DINOTHAWR_VERSION = 33fb82a8df4e440f96d19bba38668beaa1b414fc
LIBRETRO_DINOTHAWR_SITE = $(call github,libretro,Dinothawr,$(LIBRETRO_DINOTHAWR_VERSION))
LIBRETRO_DINOTHAWR_LICENSE = Custom, CC-BY-NC-SA-3.0 (assets, game data)
LIBRETRO_DINOTHAWR_LICENSE_FILES = LICENSE
LIBRETRO_DINOTHAWR_NON_COMMERCIAL = y

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
NEON=1
else
NEON=0
endif

define LIBRETRO_DINOTHAWR_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) HAVE_NEON=$(NEON) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_DINOTHAWR_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	mkdir -p "${BINARIES_DIR}/retroarch/system/dinothawr/assets"
	$(INSTALL) -D $(@D)/dinothawr_libretro.so \
		${BINARIES_DIR}/retroarch/cores/dinothawr_libretro.so
	cp -R $(@D)/dinothawr/* \
		${BINARIES_DIR}/retroarch/system/dinothawr
endef

$(eval $(generic-package))
