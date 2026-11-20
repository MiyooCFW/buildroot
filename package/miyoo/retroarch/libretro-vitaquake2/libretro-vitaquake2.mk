################################################################################
#
# VITAQUAKE2
#
################################################################################

LIBRETRO_VITAQUAKE2_VERSION = a74ca613ef71ed910a3cf49e71aa3c5f0294d9bf
LIBRETRO_VITAQUAKE2_SITE = $(call github,libretro,vitaquake2,$(LIBRETRO_VITAQUAKE2_VERSION))
LIBRETRO_VITAQUAKE2_CONFIG_VERSION = m4
LIBRETRO_VITAQUAKE2_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/Apaczer/quake2-miyoo/refs/tags/$(LIBRETRO_VITAQUAKE2_CONFIG_VERSION)/config/autoexec.cfg

LIBRETRO_VITAQUAKE2_LICENSE = GPL-2.0
LIBRETRO_VITAQUAKE2_LICENSE_FILES = LICENSE
LIBRETRO_VITAQUAKE2_DEPENDENCIES = zlib

define LIBRETRO_VITAQUAKE2_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS)" \
		$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AS="$(TARGET_AS)" -C $(@D) -f Makefile \
			platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_VITAQUAKE2_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/vitaquake2_libretro.so \
		${BINARIES_DIR}/retroarch/cores/vitaquake2_libretro.so
	# Create optimization custom cfg in the system dir
	mkdir -p "$(BINARIES_DIR)/retroarch/system/vitaquake2"
	cp $(LIBRETRO_VITAQUAKE2_DL_DIR)/autoexec.cfg $(BINARIES_DIR)/retroarch/system/vitaquake2/custom.cfg
endef

$(eval $(generic-package))
