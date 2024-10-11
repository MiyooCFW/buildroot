################################################################################
#
# ARDUOUS
#
################################################################################

# Commit version of 2022/05/24
LIBRETRO_ARDUOUS_VERSION = aed50506962df6f965748e888b3fe7027ddb410d
LIBRETRO_ARDUOUS_SITE = https://github.com/libretro/arduous.git
LIBRETRO_ARDUOUS_SITE_METHOD = git
LIBRETRO_ARDUOUS_GIT_SUBMODULES = YES
LIBRETRO_ARDUOUS_LICENSE = GPLv3
LIBRETRO_ARDUOUS_CONF_ENV=CXX=$(TARGET_CXX) CC=$(TARGET_CC)
LIBRETRO_ARDUOUS_CONF_OPTS=-DCMAKE_POSITION_INDEPENDENT_CODE=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=
define LIBRETRO_ARDUOUS_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
		$(INSTALL) -D $(@D)/arduous_libretro.so \
				${BINARIES_DIR}/retroarch/cores/arduous_libretro.so
endef

$(eval $(cmake-package))
