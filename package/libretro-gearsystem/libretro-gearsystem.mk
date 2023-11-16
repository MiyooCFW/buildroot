################################################################################
#
# GEARSYSTEM
#
################################################################################

# acf84e235ff5716822905dc5107e7fe8fa6b9509 = Latest working comits on RPi2/3
# Commit of 2023/08/23
LIBRETRO_GEARSYSTEM_VERSION = c58a865a727e6f7b83123a1a261c13bcc1b0f0dc
LIBRETRO_GEARSYSTEM_SITE = $(call github,drhelius,Gearsystem,$(LIBRETRO_GEARSYSTEM_VERSION))
LIBRETRO_GEARSYSTEM_LICENSE = GPL-3.0
LIBRETRO_GEARSYSTEM_LICENSE_FILES = LICENSE

define LIBRETRO_GEARSYSTEM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/platforms/libretro/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/platforms/libretro -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/platforms/libretro/*_libretro.so
endef

define LIBRETRO_GEARSYSTEM_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/platforms/libretro/gearsystem_libretro.so \
		${BINARIES_DIR}/retroarch/cores/gearsystem_libretro.so
endef

$(eval $(generic-package))
