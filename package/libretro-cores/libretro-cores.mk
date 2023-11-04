LIBRETRO_CORES_VERSION = origin/master
LIBRETRO_CORES_SITE_METHOD = git
LIBRETRO_CORES_SITE = https://github.com/libretro/libretro-super.git
LIBRETRO_CORES_LICENSE = GPL-3.0
LIBRETRO_CORES_LICENSE_FILES = COPYING
LIBRETRO_CORES_DEPENDENCIES = host-pkgconf sdl sdl_image sdl_mixer sdl_sound sdl_ttf
ifeq ($(BR2_TOOLCHAIN_BUILDROOT_LIBC),"musl")
mgba_platform=unix
else
mgba_platform=miyoo
endif

define LIBRETRO_CORES_CONFIGURE_CMDS
    cd $(@D) && \
    ./libretro-fetch.sh 2048 81 a5200 arduous atari800 bk bluemsx cannonball cap32 chailove \
    dinothawr ecwolf fceumm fmsx freechaf freeintv fuse gambatte gearboy gearcoleco gearsystem \
    genesis_plus_gx genesis_plus_gx_wide gme gong gpsp gw handy jaxe jumpnbump lowresnx lutro \
    mame2000 mame2003 mame2003_plus mednafen_pce_fast mednafen_wswan mgba minivmac mrboom numero \
    nxengine o2em pcsx_rearmed picodrive pocketcdg pokemini potator prboom prosystem quasi88 \
    quicknes race reminiscence retro8 smsplus snes9x2002 snes9x2005 stella2014 theodore tic80 \
    tyrquake uw8 vaporspec vecx vemulator wasm4 x1 xrick
endef

define LIBRETRO_CORES_BUILD_CMDS
    cd $(@D) && \
    platform=miyoo ARCH=arm CC=$(TARGET_CC) CXX=$(TARGET_CXX) STRIP=$(TARGET_STRIP) ./libretro-build.sh \
    2048 81 a5200 arduous atari800 bk bluemsx cannonball cap32 chailove dinothawr ecwolf fceumm fmsx \
    freechaf freeintv fuse gambatte gearboy gearcoleco gearsystem genesis_plus_gx genesis_plus_gx_wide \
    gme gong gpsp gw handy jaxe jumpnbump lowresnx lutro mame2000 mame2003 mame2003_plus mednafen_pce_fast \
    mednafen_wswan minivmac mrboom numero nxengine o2em pcsx_rearmed pocketcdg pokemini \
    potator prboom prosystem quasi88 quicknes race reminiscence retro8 smsplus snes9x2002 snes9x2005 \
    stella2014 theodore tic80 tyrquake uw8 vaporspec vecx vemulator wasm4 x1 xrick
    cd $(@D) && \
    platform=$(mgba_platform) ARCH=arm CC=$(TARGET_CC) CXX=$(TARGET_CXX) STRIP=$(TARGET_STRIP) ./libretro-build.sh mgba
    cd $(@D) && \
    TARGET_CC=$(TARGET_CC) platform=miyoo ARCH=arm ./libretro-build.sh picodrive
    $(TARGET_STRIP) --strip-unneeded $(@D)/dist/unix/* 
endef

define LIBRETRO_CORES_INSTALL_TARGET_CMDS
    mkdir -p "${BINARIES_DIR}/retroarch/cores"
    mkdir -p "${BINARIES_DIR}/retroarch/core_info"
    $(INSTALL) -D -m 0644 $(@D)/dist/unix/* "${BINARIES_DIR}/retroarch/cores/"
    $(INSTALL) -D -m 0644 $(@D)/libretro-picodrive/picodrive_libretro.so "${BINARIES_DIR}/retroarch/cores/"
    $(INSTALL) -D -m 0644 $(@D)/dist/info/* "${BINARIES_DIR}/retroarch/core_info/"
endef

$(eval $(generic-package))