#!/bin/sh
name=/mnt/screenshots/system
mkdir -p /mnt/screenshots
if [[ -e $name.png ]] ; then
    i=1
    while [[ -e $name-$i.png ]] ; do
        let i++
    done
    name=$name-$i
fi
/mnt/apps/fbgrab/fbgrab "$name".png
