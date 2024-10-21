################################################################################
#
# FREEINTV
#
################################################################################

# Commit of 2023/04/17
LIBRETRO_FREEINTV_VERSION = 85bf25a39a34bbc39fe36677175d87c2b597dbe7
LIBRETRO_FREEINTV_SITE = $(call github,libretro,FreeIntv,$(LIBRETRO_FREEINTV_VERSION))
LIBRETRO_FREEINTV_LICENSE = GPL-2.0+
LIBRETRO_FREEINTV_LICENSE_FILES = LICENSE

define LIBRETRO_FREEINTV_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_NOLTO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_NOLTO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_NOLTO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_CXX)" AR="$(TARGET_AR)" RANLIB="$(TARGET_RANLIB)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FREEINTV_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/freeintv_libretro.so \
		${BINARIES_DIR}/retroarch/cores/freeintv_libretro.so
endef

$(eval $(generic-package))
