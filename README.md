# Buildroot Package for Miyoo CFW 2.0.0
Opensource development package for Miyoo handhelds

## Install

### Install necessary packages
``` shell
sudo apt install -y wget unzip build-essential git bc swig libncurses-dev libpython3-dev libssl-dev cpio rsync subversion python3
```

### Download BSP
```shell
git clone https://github.com/MiyooCFW/buildroot
```

## Make the first build

### Apply defconfig uClibc

```shell
cd buildroot
make miyoo_uclibc_defconfig
```

### Or apply defconfig musl

```shell
cd buildroot
make miyoo_musl_defconfig
```

### Regular build
```shell
make
```

## Speed up build progress

### Compile speed
If you have a multicore CPU, you can try
```
make -j ${YOUR_CPU_COUNT}
```
or buy a powerful PC for yourself.

## Flashing firmware to target

load output/images/miyoo-cfw-2.0.0.img on sdcard
