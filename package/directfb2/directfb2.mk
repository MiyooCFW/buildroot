################################################################################
#
# directfb2
#
################################################################################

DIRECTFB2_VERSION = 4d6b7ddd8477b4b52aa78ec82a3add28ade0c965
DIRECTFB2_SITE = $(call github,directfb2,DirectFB2,$(DIRECTFB2_VERSION))
DIRECTFB2_DEPENDENCIES = host-flux
DIRECTFB2_LICENSE = LGPL-2.1
DIRECTFB2_INSTALL_STAGING = YES

DIRECTFB2_CFLAGS = $(TARGET_CFLAGS) -O3
DIRECTFB2_CXXFLAGS = $(TARGET_CFLAGS) -O3
DIRECTFB2_CONF_OPTS += -Dneon=false

ifeq ($(BR2_GCC_ENABLE_LTO),y)
DIRECTFB2_CFLAGS += -flto
DIRECTFB2_CXXFLAGS += -flto
endif

ifeq ($(BR2_PACKAGE_DIRECTFB2_MULTI),y)
DIRECTFB2_CONF_OPTS += -Dmulti=true
endif

ifeq ($(BR2_PACKAGE_DIRECTFB2_MULTI_KERNEL),y)
DIRECTFB2_CONF_OPTS += -Dmulti-kernel=true
endif

ifeq ($(BR2_PACKAGE_DIRECTFB2_DRMKMS),y)
DIRECTFB2_CONF_OPTS += -Ddrmkms=true
DIRECTFB2_DEPENDENCIES += libdrm
else
DIRECTFB2_CONF_OPTS += -Ddrmkms=false
endif

ifeq ($(BR2_PACKAGE_DIRECTFB2_FBDEV),y)
DIRECTFB2_CONF_OPTS += -Dfbdev=true
else
DIRECTFB2_CONF_OPTS += -Dfbdev=false
endif

$(eval $(meson-package))
