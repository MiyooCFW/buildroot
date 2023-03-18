fatload mmc 0:1 0x80008000 uEnv.txt
env import -t 0x80008000 ${filesize}
run bootcmd_args
load mmc 0:1 0x80C00000 suniv-f1c500s-miyoo-4bit.dtb
load mmc 0:1 0x80008000 zImage
bootz 0x80008000 - 0x80C00000
