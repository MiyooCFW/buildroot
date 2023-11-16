################################################################################
#
# O2EM
#
################################################################################

# Commit of 2023/10/19
LIBRETRO_O2EM_VERSION = 44fe5f306033242f7d74144105e19a7d4939477e
LIBRETRO_O2EM_SITE = $(call github,libretro,libretro-o2em,$(LIBRETRO_O2EM_VERSION))
LIBRETRO_O2EM_LICENSE = ARTISTIC
LIBRETRO_O2EM_LICENSE_FILES = COPYING

define LIBRETRO_O2EM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_O2EM_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/o2em_libretro.so \
		${BINARIES_DIR}/retroarch/cores/o2em_libretro.so
endef

$(eval $(generic-package))
