################################################################################
#
# FCEUMM
#
################################################################################

# Commit of 2023/09/16
LIBRETRO_FCEUMM_VERSION = 7fad08e5522e5396a1196055fc106be9b5d5de77
LIBRETRO_FCEUMM_SITE = $(call github,libretro,libretro-fceumm,$(LIBRETRO_FCEUMM_VERSION))
LIBRETRO_FCEUMM_LICENSE = GPL-2.0
LIBRETRO_FCEUMM_LICENSE_FILES = Copying

define LIBRETRO_FCEUMM_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FCEUMM_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/fceumm_libretro.so \
		${BINARIES_DIR}/retroarch/cores/fceumm_libretro.so
endef

$(eval $(generic-package))
