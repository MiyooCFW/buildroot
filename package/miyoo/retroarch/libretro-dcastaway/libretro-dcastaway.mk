################################################################################
#
# DCASTAWAY
#
################################################################################

LIBRETRO_DCASTAWAY_VERSION = 91780ee247f78c7cd827af0fbc428b4cfa24c4c3
LIBRETRO_DCASTAWAY_EMUTOS_VERSION = 0.9.12
LIBRETRO_DCASTAWAY_EXTRA_DOWNLOADS = https://master.dl.sourceforge.net/project/emutos/emutos/$(LIBRETRO_DCASTAWAY_EMUTOS_VERSION)/emutos-192k-$(LIBRETRO_DCASTAWAY_EMUTOS_VERSION).zip
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
	# Install compatible EmuTOS English PAL ver.
	mkdir -p "$(BINARIES_DIR)/retroarch/system/dcastaway"
	unzip -jo $(LIBRETRO_DCASTAWAY_DL_DIR)/emutos-192k-$(LIBRETRO_DCASTAWAY_EMUTOS_VERSION).zip emutos-192k-$(LIBRETRO_DCASTAWAY_EMUTOS_VERSION)/etos192uk.img -d $(LIBRETRO_DCASTAWAY_DL_DIR)
	mv $(LIBRETRO_DCASTAWAY_DL_DIR)/etos192uk.img $(BINARIES_DIR)/retroarch/system/dcastaway/tos.rom
endef

$(eval $(generic-package))
