#!/bin/sh

start_retroarch_func(){
  cd /mnt/emus/retroarch
  if ! read -n 1 -t 1 -s; then
    local history_path='/mnt/.retroarch/content_history.lpl'
    if test -f "${history_path}"; then
      local rom_path="$(head -n20 "${history_path}" | grep -Eo -m1 '/mnt/roms/[^"]+')"
      local core_path="$(head -n20 "${history_path}" | grep -Eo -m1 '/mnt/.retroarch/cores/.+\.so')"
      if test -f "${core_path}" -a -f "${rom_path}"; then
        clear
        echo -e "\n\n\n\n\n\n\n\n\n\n\n\n\n\n              \e[1;33m[ LOADING ]\e[0m"
        ./retroarch --load-menu-on-error --libretro "${core_path}" "${rom_path}" > /dev/null 2>&1
        return
      fi
    fi
  fi
  ./retroarch --menu > /dev/null 2>&1
}

start_retroarch_func
