IPK_RACE_VERSION = v3
IPK_RACE_SITE = https://github.com/Apaczer/race-od/releases/download/$(IPK_RACE_VERSION)
IPK_RACE_SOURCE = race.ipk
IPK_RACE_INSTALL_TARGET = YES

define IPK_RACE_EXTRACT_CMDS
    cd $(@D) && ar x $(DL_DIR)/ipk-race/$(IPK_RACE_SOURCE)
endef

define IPK_RACE_INSTALL_TARGET_CMDS
    mkdir -p $(BINARIES_DIR)/main
    tar -xzf $(@D)/data.tar.gz --strip-components=2 -C $(BINARIES_DIR)/main
endef

$(eval $(generic-package))