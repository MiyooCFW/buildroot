#!/bin/busybox sh

mkdir -p /run/dropbear
echo "Launching dropbear app"
dropbear -R -B
