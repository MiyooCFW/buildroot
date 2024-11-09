IPK_RACE_VERSION = v3
IPK_RACE_SITE = https://github.com/Apaczer/race-od/releases/download/$(IPK_RACE_VERSION)
IPK_RACE_SOURCE = race.ipk
IPK_RACE_INSTALL_TARGET = YES
IPK_RACE_LICENSE = GPL-2.0
#IPK_RACE_LICENSE_FILES = License.txt

define IPK_RACE_EXTRACT_CMDS
    cd $(@D) && cp $(DL_DIR)/ipk-race/$(IPK_RACE_SOURCE) .
endef

define IPK_RACE_INSTALL_TARGET_CMDS
	mkdir -p $(BINARIES_DIR)/main/pkgs
	$(INSTALL) -D -m 0666 $(@D)/$(IPK_RACE_SOURCE) $(BINARIES_DIR)/main/pkgs
endef

$(eval $(generic-package))
