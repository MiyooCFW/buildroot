################################################################################
#
# SDLbook
#
################################################################################

SDLBOOK_VERSION = d0c4df8edf8df4f96312641ebf4d25d5b0b042fe
SDLBOOK_SITE_METHOD = git
SDLBOOK_SITE = https://github.com/rofl0r/SDLBook
SDLBOOK_DEPENDENCIES = \
	sdl \
	djvu \
	mupdf \
	tiff

define SDLBOOK_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" \
	CFLAGS="-Ofast -ffast-math -mcpu=arm926ej-s -marm -fdata-sections -ffunction-sections -fsingle-precision-constant -flto \
			-fdata-sections -ffunction-sections -Wl,--gc-sections \
			-fno-stack-protector -fno-ident -fomit-frame-pointer \
			-falign-functions=1 -falign-jumps=1 -falign-loops=1 \
			-fno-unwind-tables -fno-asynchronous-unwind-tables -fno-unroll-loops \
			-fmerge-all-constants -fno-math-errno" \
	-C $(@D)
endef

define SDLBOOK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sdlbook $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
