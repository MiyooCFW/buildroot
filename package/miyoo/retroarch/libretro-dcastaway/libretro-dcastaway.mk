################################################################################
#
# DCASTAWAY
#
################################################################################

LIBRETRO_DCASTAWAY_VERSION = 120cabfc51d9bc6eef3a17a5915e3d913baf9cf0
LIBRETRO_DCASTAWAY_SITE = $(call github,Apaczer,DCaSTaway,$(LIBRETRO_DCASTAWAY_VERSION))
LIBRETRO_DCASTAWAY_LICENSE = GPL-2.0
LIBRETRO_DCASTAWAY_LICENSE_FILES = LICENSE.md
LIBRETRO_DCASTAWAY_DEPENDENCIES = zlib

define LIBRETRO_DCASTAWAY_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS)" \
		$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AS="$(TARGET_AS)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_DCASTAWAY_INSTALL_TARGET_CMDS
	mkdir -p "$(BINARIES_DIR)/retroarch/cores"
	$(INSTALL) -D $(@D)/dcastaway_libretro.so \
		$(BINARIES_DIR)/retroarch/cores/dcastaway_libretro.so
endef

$(eval $(generic-package))
