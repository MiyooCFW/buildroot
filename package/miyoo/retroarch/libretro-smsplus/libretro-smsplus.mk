################################################################################
#
# SMSPLUS
#
################################################################################

LIBRETRO_SMSPLUS_VERSION = 96fa9bc65aa27a5ab2779f9f2ff0439fec7cf513
LIBRETRO_SMSPLUS_SITE = $(call github,libretro,smsplus-gx,$(LIBRETRO_SMSPLUS_VERSION))
LIBRETRO_SMSPLUS_LICENSE = GPL-2.0
LIBRETRO_SMSPLUS_LICENSE_FILES = docs/license

define LIBRETRO_SMSPLUS_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_SMSPLUS_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/smsplus_libretro.so \
		${BINARIES_DIR}/retroarch/cores/smsplus_libretro.so
endef

$(eval $(generic-package))
