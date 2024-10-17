LIBRETRO_DATABASE_VERSION = 1.16.0.3
LIBRETRO_DATABASE_SITE = $(call github,libretro,libretro-database,v${LIBRETRO_DATABASE_VERSION})
LIBRETRO_DATABASE_LICENSE = CC-BY-SA-4.0
LIBRETRO_DATABASE_LICENSE_FILES = LICENSE

define LIBRETRO_DATABASE_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
        mkdir -p "${BINARIES_DIR}/retroarch/cursors"
        mkdir -p "${BINARIES_DIR}/retroarch/rdb"
        $(INSTALL) -D -m 0644  $(@D)/cursors/* "${BINARIES_DIR}/retroarch/cursors/"
	$(INSTALL) -D -m 0644 $(@D)/rdb/* "${BINARIES_DIR}/retroarch/rdb/"
endef

$(eval $(generic-package))
