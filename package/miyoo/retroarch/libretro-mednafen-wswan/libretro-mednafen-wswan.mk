################################################################################
#
# MEDNAFEN_WSWAN
#
################################################################################

LIBRETRO_MEDNAFEN_WSWAN_VERSION = 32bf70a3032a138baa969c22445f4b7821632c30
LIBRETRO_MEDNAFEN_WSWAN_SITE = $(call github,libretro,beetle-wswan-libretro,$(LIBRETRO_MEDNAFEN_WSWAN_VERSION))
LIBRETRO_MEDNAFEN_WSWAN_LICENSE = GPL-2.0
LIBRETRO_MEDNAFEN_WSWAN_LICENSE_FILES = COPYING

define LIBRETRO_MEDNAFEN_WSWAN_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MEDNAFEN_WSWAN_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/mednafen_wswan_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mednafen_wswan_libretro.so
endef

$(eval $(generic-package))
