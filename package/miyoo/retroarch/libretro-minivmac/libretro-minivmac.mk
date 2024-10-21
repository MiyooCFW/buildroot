################################################################################
#
# MINIVMAC
#
################################################################################

# Commit of 2022/12/07
LIBRETRO_MINIVMAC_VERSION = 45edc82baae906b90b67cce66761557923a6ba75
LIBRETRO_MINIVMAC_SITE = https://github.com/libretro/libretro-minivmac.git
LIBRETRO_MINIVMAC_SITE_METHOD = git
LIBRETRO_MINIVMAC_LICENSE = GPL-2.0
LIBRETRO_MINIVMAC_LICENSE_FILES = minivmac/COPYING.txt
LIBRETRO_MINIVMAC_GIT_SUBMODULES=y

define LIBRETRO_MINIVMAC_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_CXX)" AR="$(TARGET_AR)" RANLIB="$(TARGET_RANLIB)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_MINIVMAC_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/minivmac_libretro.so \
		${BINARIES_DIR}/retroarch/cores/minivmac_libretro.so
endef

$(eval $(generic-package))
