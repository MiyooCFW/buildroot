################################################################################
#
# MRBOOM
#
################################################################################

# Commit of 2023/10/06
LIBRETRO_MRBOOM_VERSION = 089b91d4dcf016d0595824d519707bed709178f2
LIBRETRO_MRBOOM_SITE = https://github.com/libretro/mrboom-libretro.git
LIBRETRO_MRBOOM_LICENSE = MIT
LIBRETRO_MRBOOM_LICENSE_FILES = LICENSE

LIBRETRO_MRBOOM_SITE_METHOD=git
LIBRETRO_MRBOOM_GIT_SUBMODULES=y

# Flag to fix build on arm platforms
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
LIBRETRO_MRBOOM_OPTIONS += HAVE_NEON=1
else
LIBRETRO_MRBOOM_OPTIONS +=
endif

define LIBRETRO_MRBOOM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)" $(LIBRETRO_MRBOOM_OPTIONS)
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MRBOOM_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/mrboom_libretro.so \
		${BINARIES_DIR}/retroarch/cores/mrboom_libretro.so
endef

$(eval $(generic-package))
