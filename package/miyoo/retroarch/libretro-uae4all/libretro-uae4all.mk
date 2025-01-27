################################################################################
#
# UAE4ALL
#
################################################################################

LIBRETRO_UAE4ALL_VERSION = e6caa7430bdcfa13e9ef1a641703075b4092e726
LIBRETRO_UAE4ALL_SITE = $(call github,Apaczer,uae4all,$(LIBRETRO_UAE4ALL_VERSION))
#LIBRETRO_UAE4ALL_BRANCH = libretro
LIBRETRO_UAE4ALL_LICENSE = GPL-2.0
LIBRETRO_UAE4ALL_LICENSE_FILES = docs/COPYING
LIBRETRO_UAE4ALL_DEPENDENCIES = zlib

define LIBRETRO_UAE4ALL_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS)" \
		$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AS="$(TARGET_AS)" -C $(@D) -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_UAE4ALL_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/uae4all_libretro.so \
		${BINARIES_DIR}/retroarch/cores/uae4all_libretro.so
endef

$(eval $(generic-package))
