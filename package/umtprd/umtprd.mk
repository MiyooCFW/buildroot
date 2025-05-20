################################################################################
#
# umtprd
#
################################################################################

UMTPRD_VERSION = 7d7d099df0dd929f95de0f45a2b6b006545207c6
UMTPRD_SITE_METHOD = git
UMTPRD_SITE = https://github.com/viveris/uMTP-Responder.git
UMTPRD_LICENSE = GPL-3.0+
UMTPRD_LICENSE_FILES = LICENSE

define UMTPRD_BUILD_CMDS
# Compile umtprd-debug
	CC=$(TARGET_CC) $(MAKE) -C $(@D) DEBUG=1 #USE_SYSLOG=1
	mv -fn $(@D)/umtprd $(@D)/umtprd-debug
# Clean prv build
	CC=$(TARGET_CC) $(MAKE) clean -C $(@D)
# Compile umtprd
	CC=$(TARGET_CC) $(MAKE) -C $(@D)
endef

define UMTPRD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/umtprd $(TARGET_DIR)/usr/sbin/umtprd
	$(INSTALL) -D -m 0755 $(@D)/umtprd-debug $(TARGET_DIR)/usr/sbin/umtprd-debug
endef

$(eval $(generic-package))
