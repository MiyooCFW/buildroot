################################################################################
#
# ZX81
#
################################################################################

# Commit of 2023/05/28
LIBRETRO_81_VERSION = 6d1b4d26aa9870133616fcfb5a763ca138ae25d1
LIBRETRO_81_SITE = $(call github,libretro,81-libretro,$(LIBRETRO_81_VERSION))
LIBRETRO_81_LICENSE = GPL-3.0
LIBRETRO_81_LICENSE_FILES = LICENSE

define LIBRETRO_81_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_81_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/81_libretro.so \
		${BINARIES_DIR}/retroarch/cores/81_libretro.so
endef

$(eval $(generic-package))
