MIYOO_CTL_VERSION = origin/master
MIYOO_CTL_SITE_METHOD = git
MIYOO_CTL_SITE = https://github.com/MiyooCFW/miyooctl.git
MIYOO_CTL_LICENSE = GPL-2.0+
MIYOO_CTL_LICENSE_FILES = LICENSE

define MIYOO_CTL_BUILD_CMDS
	"$(TARGET_CC)" $(@D)/main.c -o $(@D)/miyooctl
endef

define MIYOO_CTL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/miyooctl $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
