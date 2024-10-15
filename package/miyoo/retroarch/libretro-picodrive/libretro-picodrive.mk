################################################################################
#
# PICODRIVE
#
################################################################################

#Commit of 2024-01-03
LIBRETRO_PICODRIVE_VERSION = 019421c9a1d70cc7d30ae4bfa60a79660a0e2bcd
LIBRETRO_PICODRIVE_SITE = https://github.com/libretro/picodrive.git
LIBRETRO_PICODRIVE_LICENSE = COPYRIGHT
LIBRETRO_PICODRIVE_LICENSE_FILES = COPYING
LIBRETRO_PICODRIVE_NON_COMMERCIAL = y

LIBRETRO_PICODRIVE_DEPENDENCIES = libpng
LIBRETRO_PICODRIVE_SITE_METHOD=git
LIBRETRO_PICODRIVE_GIT_SUBMODULES=y

define LIBRETRO_PICODRIVE_BUILD_CMDS
	$(MAKE) -C $(@D)/cpu/cyclone CONFIG_FILE=$(@D)/cpu/cyclone_config_armv4.h
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO) -I '$(@D)'" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO) -I '$(@D)'" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO) -I '$(@D)'" \
		$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" -C  $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_PICODRIVE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/picodrive_libretro.so \
		${BINARIES_DIR}/retroarch/cores/picodrive_libretro.so
endef

$(eval $(generic-package))
