################################################################################
#
# GMenu2X
#
################################################################################

GMENU2X_VERSION = origin/master
GMENU2X_SITE_METHOD = git
GMENU2X_SITE = https://github.com/MiyooCFW/gmenu2x.git
GMENU2X_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_sound sdl_ttf

GMENU2X_BUILDTIME = \"$(shell date +%F\ %H:%M)\"
GMENU2X_BUILDROOT_HASH = $(shell git rev-parse --short HEAD)
GMENU2X_HASH = -D__BUILDTIME__=$(GMENU2X_BUILDTIME) -D__BUILDROOT_HASH__=$(GMENU2X_BUILDROOT_HASH) -DLOG_LEVEL=3 \
	-D__COMMIT_HASH__=$(shell git -C $(GMENU2X_DL_DIR)/git rev-parse --short HEAD)
ifdef CFW_HASH
ifneq ($(CFW_HASH), $(GMENU2X_BUILDROOT_HASH))
GMENU2X_HASH += -D__CFW_HASH__=$(CFW_HASH)
endif
endif

define GMENU2X_BUILD_CMDS
	$(MAKE) GMENU2X_HASH="$(GMENU2X_HASH)" CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" STRIP="$(TARGET_STRIP)" LD="$(TARGET_LD)" -C $(@D) -f Makefile.miyoo dist
endef

define GMENU2X_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/gmenu2x/
	cp -r $(@D)/dist/miyoo/* $(BINARIES_DIR)/gmenu2x/
endef

$(eval $(generic-package))
