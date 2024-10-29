#!/bin/bash
export TERM=linux
ipk_directory="/mnt/ipk"
package_list=()

for ipk_file in "$ipk_directory"/*.ipk; do
    if [[ -f "$ipk_file" ]]; then
        package_info=$(opkg info "$ipk_file")
        package_name=$(echo "$package_info" | grep "^Package:" | cut -d' ' -f2)
        package_description=$(echo "$package_info" | grep "^Description:" | cut -d' ' -f2-)

        if [[ -n "$package_name" ]]; then
            package_list+=("$package_name" "$package_description" "off")
        fi
    fi
done

if [[ ${#package_list[@]} -eq 0 ]]; then
    echo "No packages to install."
    exit 1
fi


selected_packages=$(dialog --no-shadow --clear --colors --visit-items --title "IPK Package manager" --checklist 'Press Y to select packages to install:' 20 80 15 "${package_list[@]}" 3>&1 1>&2 2>&3)

if [[ $? -ne 0 || -z "$selected_packages" ]]; then
    echo "No packages were selected."
    exit 1
fi

for package in $selected_packages; do
    ipk_package="${package}.ipk"
    echo "Installing $ipk_package..."
    if opkg install "$ipk_directory/$ipk_package" 2>/dev/null; then
        echo "$ipk_package installed successfully."
    else
        echo "Failed to install $ipk_package."
    fi
done

echo "Installation complete."
