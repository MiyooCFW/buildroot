################################################################################
#
# x264
#
################################################################################

X264_VERSION = 72d53ab2ac7af24597a824e868f2ef363a22f5d4
X264_SITE = http://sources.buildroot.net
X264_LICENSE = GPLv2+
X264_DEPENDENCIES = host-pkgconf
X264_LICENSE_FILES = COPYING
X264_INSTALL_STAGING = YES
X264_CONF_OPTS = --disable-avs

ifeq ($(BR2_i386)$(BR2_x86_64),y)
# yasm needed for assembly files
X264_DEPENDENCIES += host-yasm
X264_CONF_ENV += AS="$(HOST_DIR)/usr/bin/yasm"
else ifeq ($(BR2_ARM_CPU_ARMV7A)$(BR2_aarch64),y)
# We need to pass gcc as AS, because the ARM assembly files have to be
# preprocessed
X264_CONF_ENV += AS="$(TARGET_CC)"
else
X264_CONF_OPTS += --disable-asm
endif

ifeq ($(BR2_STATIC_LIBS),)
X264_CONF_OPTS += --enable-pic --enable-shared
endif

ifeq ($(BR2_PACKAGE_X264_CLI),)
X264_CONF_OPTS += --disable-cli
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),)
X264_CONF_OPTS += --disable-thread
endif

# the configure script is not generated by autoconf
define X264_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) $(X264_CONF_ENV) ./configure \
		--prefix=/usr \
		--host="$(GNU_TARGET_NAME)" \
		--cross-prefix="$(TARGET_CROSS)" \
		--disable-ffms \
		--enable-static \
		--disable-opencl \
		$(X264_CONF_OPTS) \
	)
endef

define X264_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define X264_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(STAGING_DIR)" -C $(@D) install
endef

define X264_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
