################################################################################
#
# FLUIDLITE
#
################################################################################

FLUIDLITE_VERSION = 1.0
FLUIDLITE_SITE = $(call github,gcw0,FluidLite,$(FLUIDLITE_VERSION))
FLUIDLITE_LICENSE = LGPL-2.1+
FLUIDLITE_LICENSE_FILES = LICENSE
FLUIDLITE_INSTALL_STAGING = YES
FLUIDLITE_DEPENDENCIES =

# Disable the shared library for static only build
ifeq ($(BR2_STATIC_LIBS),y)
FLUIDLITE_CONF_OPTS += -DFLUIDLITE_BUILD_SHARED=FALSE
endif

$(eval $(cmake-package))
