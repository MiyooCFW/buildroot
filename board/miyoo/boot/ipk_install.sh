#!/bin/bash

export TERM=linux
export HELP="Info"
WARN="
MiyooCFW team is not responsible for any issues \
arising from the use of third-party applications \
with current software. Support, bug fixes, or \
improvements for 3rd-party apps are not provided \
by our team members unless explicitly stated otherwise \
(contact Maintainer of the app).
\n\n
\Z5 Do you still wish to CONTINUE with install?\Zn
\n\n
   Select an option & press START"
ipk_directory="/mnt/pkgs"
package_list=()
help_messages=()
index=1
for ipk_file in "$ipk_directory"/*.ipk; do
    if [[ -f "$ipk_file" ]]; then
	ipk_name=$(basename -s .ipk "$ipk_file")
	package_list+=("$index" "$ipk_name" "off")
	help_messages[$((2 * index))]="$index"
	help_messages[$((2 * index + 1))]="$ipk_file"
	((index++))
    fi
done
if [[ ${#package_list[@]} -eq 0 ]]; then
    echo "No packages to install."
    exit 1
fi

dialog --backtitle "MiyooCFW 2.0" --timeout 10 --title "IPK package manager" --colors --no-shadow --msgbox "\nSelect pkg with \Zb\Z3Y\Zn button on the list." 8 28
until selected_packages=$(dialog --backtitle "MiyooCFW 2.0" --title "IPK package manager" --colors --no-shadow --help-button --help-status --checklist "Press \Zb\Z3Y\Zn to select packages (non RetroArch) to install:" 20 60 15 "${package_list[@]}" 3>&1 1>&2 2>&3); do
    case $? in
	(1) btn=Cancel && break;;
	(2)
	    set -- $selected_packages
	    shift
	    index=$1
	    package_info=$(opkg info "${help_messages[$((2 * index + 1))]}")
	    package_name=$(echo "$package_info" | grep "^Package:" | cut -d' ' -f2)
	    package_description=$(echo "$package_info" | grep "^Description:" | cut -d' ' -f2-)
	    package_version=$(echo "$package_info" | grep "^Version:" | cut -d' ' -f2-)
	    package_source=$(echo "$package_info" | grep "^Source:" | cut -d' ' -f2-)
	    package_maintainer=$(echo "$package_info" | grep "^Maintainer:" | cut -d' ' -f2-)
	    dialog --backtitle "MiyooCFW 2.0" --no-shadow --msgbox "$package_name\n\n$package_description\n\nVersion: $package_version\nMaintainer: $package_maintainer\nSource: $package_source" 0 0
	    for ((i = 2; i < ${#package_list[@]}; i += 3)); do
		package_list[$i]="off"
	    done
	    shift
	    for selected in "$@"; do
		package_list[$((3 * selected - 1))]="on"
	    done
    esac
done

clear
if [[ $? -ne 0 || -z "$selected_packages" ]]; then
    echo "No packages were selected."
    exit 1
fi

if (dialog --backtitle "MiyooCFW 2.0" --no-shadow --clear --stdout --title "WARNING" \
	--colors --pause "\n              \ZbMiyooCFW\Zn\n$WARN" 22 60 30 || test $? -eq 255); then
	clear
	for package in $selected_packages; do
		ipk_package="${help_messages[$((2 * package + 1))]}"
		echo "Installing $ipk_package..."
		if opkg install "$ipk_package" 2>/dev/null; then
		echo "$ipk_package installed successfully."
		else
		echo "Failed to install $ipk_package."
		fi
	done
	echo "Installation complete."
else
	clear
	echo "Installation complete."
fi
