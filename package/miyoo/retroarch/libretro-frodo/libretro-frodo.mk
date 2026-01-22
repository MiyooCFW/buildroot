################################################################################
#
# FRODO
#
################################################################################

LIBRETRO_FRODO_VERSION = 03b2c45bc6ce1439453f81769abc292b2944f929
LIBRETRO_FRODO_SITE = $(call github,Apaczer,frodo4,$(LIBRETRO_FRODO_VERSION))
#LIBRETRO_FRODO_BRANCH = libretro
LIBRETRO_FRODO_LICENSE = GPL-2.0
LIBRETRO_FRODO_LICENSE_FILES = COPYING
LIBRETRO_FRODO_DEPENDENCIES = zlib

define LIBRETRO_FRODO_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS)" \
		$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AS="$(TARGET_AS)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FRODO_INSTALL_TARGET_CMDS
	mkdir -p "$(BINARIES_DIR)/retroarch/cores"
	$(INSTALL) -D $(@D)/frodo_libretro.so \
		$(BINARIES_DIR)/retroarch/cores/frodo_libretro.so
endef

$(eval $(generic-package))
