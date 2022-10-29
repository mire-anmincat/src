#!/bin/sh

[ "$(whoami)" != "root" ] && echo "root required" && exit 1

scripts/00rootfs
scripts/01pkgs
scripts/02clean
scripts/03rootfs_files
scripts/05kernel_modules
scripts/06pack_rootfs
scripts/07build_iso
