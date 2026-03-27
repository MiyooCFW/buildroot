#!/bin/sh
#echo $0 $*    # for debugging

## Externel arg. variables
current_system=$1
current_rom="$2"

## External (imported) variables
DEBUG=${DEBUG:="no"}
PC_DEBUG=${PC_DEBUG:=""}
NO_SHELLECT=${NO_SHELLECT:=false}
BOXART_DIR=${BOXART_DIR:=".images"}
if ! test -z ${PC_DEBUG}; then
	DEBUG="yes"
	ScraperConfigFile=${ScraperConfigFile:="${HOME}/.scraper.cfg"}
	HOME=${HOME:="/home"}
	ROMS=${ROMS:="${HOME}/roms"}
else
	ScraperConfigFile=${ScraperConfigFile:="${HOME}/apps/scraper/.scraper.cfg"}
	HOME=${HOME:="/mnt"}
	ROMS=${ROMS:="/roms"}
fi

# global functions
wait_msg() {
	if ! test -z ${PC_DEBUG}; then
		sleep 3
	else
	## read is different in POSIX shell (should work on BusyBox)
		read -n 1 -s -r -p "Press START to continue"
	fi
}

echo_psx() {
	if ! test -z ${PC_DEBUG}; then
		#echo in real POSIX shell doesn't use opt parameters like `-e` (only \n in [string])
		echo "$1"
	else
		#echo with in BUSYBOX is more like dash, need to use `-e` opt and add escape operands like \n
		echo -e "$1"
	fi
}

if test x"$DEBUG" = "xyes"; then
	echo "DEBUG=$DEBUG"
	echo "PC_DEBUG=$PC_DEBUG"
	echo "ROMS=$ROMS\n"
	echo "current_system=${current_system}"
	echo "current_rom=${current_rom}\n"
	wait_msg
fi

if [ -z "$1" ]; then
	echo_psx "\nusage : scraper_libretro.sh emu_folder_name [rom_name]"
	echo_psx "example_1 : ./scraper_libretro.sh NES"
	echo_psx "example_2 : ./scraper_libretro.sh NES Battletoads\ \(USA\).nes\n"
	#for PC_DEBUG run e.g.: ROMS=/home/roms PC_DEBUG=1 scraper_libretro.sh NES Battletoads\ \(USA\).nes
	exit
fi

# Internal variables
# Recommended ShellectApp=/usr/bin/shellect
if ! command -v shellect > /dev/null; then
	NO_SHELLECT=true
	test x"$DEBUG" = "xyes" && \
		echo_psx "WARNING: Missing dependence! Please install \"shellect\" script in your PATH!"
fi
NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
BLINK='\x1b[5m'

romcount=0
scrap_success=0
scrap_fail=0
scrap_notrequired=0

get_ra_alias(){
	# find the corresponding remoteSystem for Libretro scraping
	case $1 in # in order from rascraper
		FBA)					remoteSystem="FBNeo - Arcade Games" ;; # ARCADE
		MAME)					remoteSystem="MAME" ;; # ARCADE
		NEOGEO)					remoteSystem="SNK - Neo Geo" ;; # ARCADE
		CPC)					remoteSystem="$1" ;; # CPC / GX4000
		ARDUBOY)				remoteSystem="Arduboy Inc - Arduboy" ;;
		800)					remoteSystem="Atari - 8-bit Family" ;;
		2600)					remoteSystem="Atari - 2600" ;;
		5200)					remoteSystem="Atari - 5200" ;;
		7800)					remoteSystem="Atari - 7800" ;;
		#Atari Jaguar
		LYNX)					remoteSystem="Atari - Lynx" ;;
		ST)						remoteSystem="Atari - ST" ;;
		#Atomiswave
		WSWAN)					remoteSystem="$1" ;; # WSWAN / WSWAN COLOR
		#CHIP-8 - no remoteSystem=""
		MSX)					remoteSystem="$1" ;; # CasioLoopy / MSX / MSX2 / Spectravideo
		#Casio PV-1000
		#Cave Story - single purpouse game
		CHAILOVE)				remoteSystem="ChaiLove" ;;
		#Cannonball - single purpouse game
		COLECOVISION)			remoteSystem="Coleco - ColecoVision" ;;
		C64)					remoteSystem="Commodore - 64" ;;
		AMIGA)					remoteSystem="Commodore - Amiga" ;;
		#Commodore CD32
		#Commodore CDTV
		#Commodore PET
		#Commodore Plus-4
		#Commodore VIC-20
		DOOM)					remoteSystem="DOOM" ;;
		DOS)					remoteSystem="DOS" ;;
		#Dinothawr - single purpouse game
		#Emerson Arcadia 2001
		#Entex Adventure Vision
		#Epoch Super Cassette Vision
		#Elektronika BK - no remoteSystem=""
		CHANNELF)				remoteSystem="Fairchild - Channel F" ;;
		FLASHBACK)				remoteSystem="Flashback" ;;
		VECTREX)				remoteSystem="GCE - Vectrex" ;;
		"G&W")					remoteSystem="Handheld Electronic Game" ;;
		GB)						remoteSystem="$1" ;; # GameBoy / GameBoyColor
		GBA)					remoteSystem="Nintendo - Game Boy Advance" ;;
		#GamePark GP32
		#Hartung Game Master
		#LeapFrog Leapster Learning Game System
		JUMPNBUMP)				remoteSystem="Jump 'n Bump" ;;
		LOWRESNX)				remoteSystem="LowRes NX" ;;
		LUTRO)					remoteSystem="Lutro" ;;
		ODYSSEY2)				remoteSystem="$1" ;; # Intellivision / Videopac+
		INT)					remoteSystem="Lutro" ;;
		#MicroW8 - no remoteSystem=""
		#MrBoom - single purpouse game
		PCE)					remoteSystem="$1" ;; # PCE / PCE-CD / PCE-SuperGrafx
		PC_88)					remoteSystem="NEC - PC-8001 - PC-8801" ;;
		#NEC - PC-98
		#NEC - PC-FX
		NES)					remoteSystem="$1" ;; # NES/FAMICOM
		POKEMINI)				remoteSystem="Nintendo - Pokemon Mini" ;;
		SNES)					remoteSystem="$1" ;; # SuperNes / Satellaview / SufamiTurbo
		#Nintendo 64
		#Nintendo DS
		#Nintendo GC
		#Nintendo Wii
		#Nintendo Wii U
		#Philips CD-i
		PS1)					remoteSystem="Sony - PlayStation" ;;
		#PS2
		#PS3
		#PSP
		#PSVITA
		QUAKE_1)				remoteSystem="Quake" ;;
		#Quake II - TODO
		#Quake III
		#RCA Studio II
		#RPG Maker - TODO
		#Rick Dangerous - single purpouse game
		SHARP_X1)				remoteSystem="Sharp - X1" ;;
		#Sharp X68000
		SCUMMVM)				remoteSystem="ScummVM" ;;
		SMS)					remoteSystem="$1" ;; # SG1000 / GameGear / MasterSystem
		SMD)					remoteSystem="$1" ;; # Genesis / SegaCD / Sega32X / PICO
		#SEGA Saturn
		#SEGA Dreamcast
		#SEGA Naomi
		#SEGA Naomi2
		#SEGA VMU - no remoteSystem=""
		Z80)					remoteSystem="Sinclair - ZX Spectrum" ;;
		ZX81)					remoteSystem="Sinclair - ZX 81" ;;
		#SNK Neo Geo CD
		NGP)					remoteSystem="$1" ;; # NGP / NGP COLOR
		#Texas Instruments - no remoteSystem=""
		#The 3DO
		TIC80)					remoteSystem="TIC-80" ;;
		THOMSON)				remoteSystem="Thomson - MOTO" ;;
		#Tiger Game.com
		#Tomb Raider - TODO
		#VTech CreatiVision
		#VTech V.Smile
		#Vircon32
		WASM4)					remoteSystem="WASM-4" ;;
		SUPERVISION)			remoteSystem="Watara - Supervision" ;;
		WOLFENSTEIN3D)			remoteSystem="Wolfenstein 3D" ;;
		#VaporSpec - no remoteSystem=""
	*)
		echo "unknown system, exiting."
		exit
		;;
esac
}

#Libretro system folder name
get_ra_alias $current_system
mkdir -p ${ROMS}/$current_system/${BOXART_DIR} &> /dev/null
clear
echo_psx "\n*****************************************************"
echo_psx "************** LIBRETRO Thumbnails ********************"
echo_psx "*****************************************************\n\n"

if test -f "${ScraperConfigFile}"; then
	media_type="$(sed -n 's:^LibretroMedia_type = ::p' "${ScraperConfigFile}" | tr -d '"')"
else
	media_type="Named_Boxarts"
fi
if [ -z "$media_type" ] && [ "$media_type" != "Named_Boxarts" ] && [ "$media_type" != "Named_Titles" ] && [ "$media_type" != "Named_Snaps" ]; then
	echo_psx " The currently selected media ($media_type)\n is not compatible with Libretro scraper.\n\n\n\n\n\n\n\n\n\n\n\n Exiting."
	sleep 5
	exit
fi
echo "Media Type: $media_type"
echo_psx "Scraping $current_system...\n"

# =================
#this is a trick to manage spaces from find command, do not indent or modify
IFS='
'
set -f
# =================

#Roms loop
if ! [ -z "$current_rom" ]; then
	romfilter="-name \"*$(echo "$current_rom" | sed -e 's_\[_\\\[_g' -e 's_\]_\\\]_g')*\""
fi

test x"$DEBUG" = "xyes" && \
	eval echo "find ${ROMS}/$current_system -maxdepth 2 -type f ! -name '.*' ! -name '*.xml' ! -name '*.db' ! -path '*/${BOXART_DIR}/*' ! -path '*/.*/*' $romfilter"
for file in $(eval "find ${ROMS}/$current_system -maxdepth 2 -type f \
	! -name '.*' ! -name '*.xml' ! -name '*.cfg' ! -name '*.db' \
	! -path '*/${BOXART_DIR}/*' ! -path '*/.*/*' $romfilter"); do

	echo "-------------------------------------------------"
	romcount=$((romcount + 1))

	# Cleaning up names
	romName=$(basename "$file")
	romNameNoExtension=${romName%.*}
	romNameNoExtensionNoSpace=$(echo $romNameNoExtension | sed 's/ /%20/g')

	echo $romNameNoExtension
	test x"$DEBUG" = "xyes" && \
		echo_psx "romNameNoExtensionNoSpace = $romNameNoExtensionNoSpace"

	top_msg="Current BoxArt System"
	bottom_msg="Press Start/Y/Right to select."

	if [ "$remoteSystem" = "NES" ]; then
		Option01="NES"
		Option02="FAMICOM"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Nintendo - Nintendo Entertainment System";;
			"$Option02") remoteSystem="Nintendo - Family Computer Disk System";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "CPC" ]; then
		Option01="CPC"
		Option02="GX4000"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Amstrad - CPC";;
			"$Option02") remoteSystem="Amstrad - GX4000";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "WSWAN" ]; then
		Option01="WSWAN"
		Option02="WSWAN COLOR"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Bandai - WonderSwan";;
			"$Option02") remoteSystem="Bandai - WonderSwan Color";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "MSX" ]; then
		Option01="CasioLoopy"
		Option02="MSX"
		Option03="MSX2"
		Option04="Spectravideo"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n$Option03\n$Option04\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option02
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Casio - Loopy";;
			"$Option02") remoteSystem="Microsoft - MSX";;
			"$Option03") remoteSystem="Microsoft - MSX2";;
			"$Option04") remoteSystem="Spectravideo - SVI-318 - SVI-328";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "GB" ]; then
		Option01="GameBoy"
		Option02="GameBoyColor"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Nintendo - Game Boy";;
			"$Option02") remoteSystem="Nintendo - Game Boy Color";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "ODYSSEY2" ]; then
		Option01="Intellivision"
		Option02="Videopac+"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Mattel - Intellivision";;
			"$Option02") remoteSystem="Philips - Videopac+";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "PCE" ]; then
		Option01="PCE"
		Option02="PCE-CD"
		Option03="PCE-SuperGrafx"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n$Option03\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="NEC - PC Engine - TurboGrafx 16";;
			"$Option02") remoteSystem="NEC - PC Engine - TurboGrafx CD";;
			"$Option03") remoteSystem="NEC - PC Engine SuperGrafx";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "SNES" ]; then
		Option01="SuperNES"
		Option02="Satellaview"
		Option03="SufamiTurbo"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n$Option03\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Nintendo - Super Nintendo Entertainment System";;
			"$Option02") remoteSystem="Nintendo - Satellaview";;
			"$Option03") remoteSystem="Nintendo - Sufami Turbo";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "SMS" ]; then
		Option01="SG1000"
		Option02="GameGear"
		Option03="MasterSystem"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n$Option03\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Sega - SG-1000";;
			"$Option02") remoteSystem="Sega - Game Gear";;
			"$Option03") remoteSystem="Sega - Master System - Mark III";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "SMD" ]; then
		Option01="Genesis"
		Option02="SegaCD"
		Option03="Sega32X"
		Option04="PICO"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n$Option03\n$Option04\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="Sega - Mega Drive - Genesis";;
			"$Option02") remoteSystem="Sega - Mega-CD - Sega CD";;
			"$Option03") remoteSystem="Sega - 32X";;
			"$Option04") remoteSystem="SEGA - PICO";;
			*) exit;;
		esac
	elif [ "$remoteSystem" = "NGP" ]; then
		Option01="NGP"
		Option02="NGP COLOR"

		if ! ${NO_SHELLECT}; then
			Mychoice=$( echo_psx "$Option01\n$Option02\n"\
						| shellect -t\ "$top_msg" -b "$bottom_msg")
		else
			Mychoice=$Option01
		fi
		case "$Mychoice" in
			"$Option01") remoteSystem="SNK - Neo Geo Pocket";;
			"$Option02") remoteSystem="SNK - Neo Geo Pocket Color";;
			*) exit;;
		esac
	fi

	remoteSystemNoSpace=$(echo $remoteSystem | sed 's/ /%20/g')
	test x"$DEBUG" = "xyes" && \
		echo_psx "remoteSystemNoSpace= $remoteSystemNoSpace"

	startcapture=true

	if [ $startcapture = true ]; then
		FILE=${ROMS}/$current_system/${BOXART_DIR}/$romNameNoExtension.png
		if [ -f "$FILE" ]; then
			echo_psx "${YELLOW}already Scraped !${NONE}"
			scrap_notrequired=$((scrap_notrequired + 1))
		else
			test x"$DEBUG" = "xyes" && \
				echo "Calling: http://thumbnails.libretro.com/$remoteSystemNoSpace/${media_type}/$romNameNoExtensionNoSpace.png"
			wget -q --spider "http://thumbnails.libretro.com/$remoteSystemNoSpace/${media_type}/$romNameNoExtensionNoSpace.png" 2>&1
			WgetResult=$?

			if [ $WgetResult = 0 ] ; then
				wget -q  "http://thumbnails.libretro.com/$remoteSystemNoSpace/${media_type}/$romNameNoExtensionNoSpace.png" -O "${ROMS}/$current_system/${BOXART_DIR}/$romNameNoExtension.png"

				## TODO: resize here -O file, or batch smwh else

				echo_psx "${GREEN}Scraped!${NONE}"
				scrap_success=$((scrap_success + 1));
			else
				echo_psx "${RED}No match found${NONE}"
				scrap_fail=$((scrap_fail + 1));
			fi
		fi
	fi
done

echo_psx "\n--------------------------"
echo "Total scanned roms	: $romcount"
echo "--------------------------"
echo "Successfully scraped	: $scrap_success"
echo "Already present		: $scrap_notrequired"
echo "Failed or not found	: $scrap_fail"
echo_psx "--------------------------\n"

echo "**********  Libretro scraping finished   **********"
wait_msg