################################################################################
#
# FUSE
#
################################################################################

# Commit of 2023/06/23
LIBRETRO_FUSE_VERSION = 847dbbd6f787823ac9a5dfacdd68ab181063374e
LIBRETRO_FUSE_SITE = $(call github,libretro,fuse-libretro,$(LIBRETRO_FUSE_VERSION))
LIBRETRO_FUSE_LICENSE = GPL-3.0
LIBRETRO_FUSE_LICENSE_FILES = LICENSE

define LIBRETRO_FUSE_BUILD_CMDS
	
	CFLAGS="$(TARGET_CFLAGS) $(COMPILER_COMMONS_CFLAGS_NOLTO)" \
		CXXFLAGS="$(TARGET_CXXFLAGS) $(COMPILER_COMMONS_CXXFLAGS_NOLTO)" \
		LDFLAGS="$(TARGET_LDFLAGS) $(COMPILER_COMMONS_LDFLAGS_NOLTO)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile.libretro platform="$(RETROARCH_LIBRETRO_PLATFORM)"
		$(TARGET_STRIP) --strip-unneeded $(@D)/*_libretro.so
endef

define LIBRETRO_FUSE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/fuse_libretro.so \
		${BINARIES_DIR}/retroarch/cores/fuse_libretro.so
endef

$(eval $(generic-package))
