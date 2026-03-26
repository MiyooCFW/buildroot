################################################################################
#
# shellect
#
################################################################################

SHELLECT_VERSION = b7fbe96e9a36889318b797d61db8c93d814aa32a
SHELLECT_SITE_METHOD = git
SHELLECT_SITE = https://github.com/huijunchen9260/shellect
SHELLECT_LICENSE = GPL-2.0
SHELLECT_LICENSE_FILES = LICENSE

# Nothing to build; only shellect script to install to target
define SHELLECT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/shellect \
		$(TARGET_DIR)/usr/bin/shellect
endef

$(eval $(generic-package))
