################################################################################
#
# sdl_mixer
#
################################################################################

# The latest officially released version of SDL_mixer is 1.2.12, released in 2012.
# Since then, there have been many bugfixes on master.
#
# This commit points to the SDL-1.2 branch from 15 Mar 2021.
SDL_MIXER_VERSION = ed76d39cda0735d26c14a3e4f4da996e420f6478
SDL_MIXER_SITE = $(call github,libsdl-org,SDL_mixer,$(SDL_MIXER_VERSION))
SDL_MIXER_LICENSE = Zlib
SDL_MIXER_LICENSE_FILES = COPYING

SDL_MIXER_INSTALL_STAGING = YES
SDL_MIXER_DEPENDENCIES = host-pkgconf sdl

SDL_MIXER_CONF_OPTS = --with-sdl-prefix=$(STAGING_DIR)/usr

ifeq ($(BR2_PACKAGE_MPG123),y)
SDL_MIXER_DEPENDENCIES += mpg123
else
SDL_MIXER_CONF_OPTS += --disable-music-mp3
endif

ifeq ($(BR2_PACKAGE_FLAC),y)
SDL_MIXER_DEPENDENCIES += flac
else
SDL_MIXER_CONF_OPTS += --disable-music-flac
endif

ifeq ($(BR2_PACKAGE_FLUIDSYNTH),y)
SDL_MIXER_DEPENDENCIES += fluidsynth
SDL_MIXER_CONF_OPTS += \
	--enable-music-midi \
	--enable-music-fluidsynth-midi
SDL_MIXER_HAS_MIDI = YES
endif

ifeq ($(BR2_PACKAGE_SDL_MIXER_MIDI_TIMIDITY),y)
SDL_MIXER_CONF_OPTS += \
	--enable-music-midi \
	--enable-music-timidity-midi
SDL_MIXER_HAS_MIDI = YES
endif

ifneq ($(SDL_MIXER_HAS_MIDI),YES)
SDL_MIXER_CONF_OPTS += --disable-music-midi
endif

ifeq ($(BR2_PACKAGE_LIBMAD),y)
SDL_MIXER_CONF_OPTS += --enable-music-mp3-mad-gpl
SDL_MIXER_DEPENDENCIES += libmad
else
SDL_MIXER_CONF_OPTS += --disable-music-mp3-mad-gpl
endif

ifeq ($(BR2_PACKAGE_LIBMIKMOD),y)
SDL_MIXER_DEPENDENCIES += libmikmod
SDL_MIXER_CONF_OPTS += LIBMIKMOD_CONFIG=$(STAGING_DIR)/usr/bin/libmikmod-config
else
SDL_MIXER_CONF_OPTS += --disable-music-mod
ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
SDL_MIXER_CONF_OPTS += --enable-music-mod-modplug
SDL_MIXER_DEPENDENCIES += libmodplug
endif
endif

ifeq ($(BR2_PACKAGE_TREMOR),y)
SDL_MIXER_CONF_OPTS += --enable-music-ogg-tremor
SDL_MIXER_DEPENDENCIES += tremor
else ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
SDL_MIXER_CONF_OPTS += --enable-music-ogg
SDL_MIXER_DEPENDENCIES += libvorbis
else
SDL_MIXER_CONF_OPTS += --disable-music-ogg
endif

define SDL_MIXER_INSTALL_BIN
	$(TARGET_STRIP) --strip-unneeded \
		$(@D)/build/playmus \
		$(@D)/build/playwave
	$(INSTALL) -D -m 0755 $(@D)/build/playmus $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/build/playwave $(TARGET_DIR)/usr/bin
endef

SDL_MIXER_POST_INSTALL_TARGET_HOOKS += SDL_MIXER_INSTALL_BIN

$(eval $(autotools-package))
