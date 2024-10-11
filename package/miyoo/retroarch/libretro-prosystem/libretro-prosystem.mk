################################################################################
#
# PROSYSTEM
#
################################################################################

# Commit of 2023/08/17
LIBRETRO_PROSYSTEM_VERSION = 4202ac5bdb2ce1a21f84efc0e26d75bb5aa7e248
LIBRETRO_PROSYSTEM_SITE = $(call github,libretro,prosystem-libretro,$(LIBRETRO_PROSYSTEM_VERSION))
LIBRETRO_PROSYSTEM_LICENSE = GPL-2.0
LIBRETRO_PROSYSTEM_LICENSE_FILES = License.txt

define LIBRETRO_PROSYSTEM_BUILD_CMDS
	$(SED) "s|-O2|-O3|g" $(@D)/Makefile
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_SO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_SO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_SO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_PROSYSTEM_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/prosystem_libretro.so \
		${BINARIES_DIR}/retroarch/cores/prosystem_libretro.so
endef

$(eval $(generic-package))
