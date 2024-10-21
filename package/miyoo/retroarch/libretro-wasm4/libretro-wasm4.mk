################################################################################
#
# WASM-4
#
################################################################################

# Commit of 2023/10/14
LIBRETRO_WASM4_VERSION = e39d89d827ea6b5ae74e682a594d44d938966958
LIBRETRO_WASM4_SITE = https://github.com/aduros/wasm4.git
LIBRETRO_WASM4_SITE_METHOD = git
LIBRETRO_WASM4_GIT_SUBMODULES = YES
LIBRETRO_WASM4_LICENSE = ISC
LIBRETRO_WASM4_LICENSE_FILES = LICENSE.txt

LIBRETRO_WASM4_SUBDIR=runtimes/native

LIBRETRO_WASM4_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
LIBRETRO_WASM4_CONF_OPTS += -DLIBRETRO=1
LIBRETRO_WASM4_CONF_OPTS += -DBUILD_LIBRETRO_CORE=ON

define LIBRETRO_WASM4_INSTALL_TARGET_CMDS
	mkdir -p "${BINARIES_DIR}/retroarch/cores"
	$(INSTALL) -D $(@D)/runtimes/native/wasm4_libretro.so \
		${BINARIES_DIR}/retroarch/cores/wasm4_libretro.so
endef

$(eval $(cmake-package))
