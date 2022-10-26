#!/bin/sh -e
# shellcheck disable=1091,3057

if [ "$(whoami)" != "root" ]; then printf "This script need to run as root.\n" && exit 1; fi

# load functions and config.
. scripts/functions
. ./config

check_tool chroot
check_tool tar
check_tool xz
check_tool cpio
check_tool wget
check_tool mkfs.vfat
check_tool mtools
check_tool xorriso

info "Checking for existing rootfs..."
[ -d rootfs ] && echo "removing..." && rm -rf rootfs

# List packages.

info
info "#####################################"
info "#       Build configuration         #"
info "#####################################"
info
info "   ISO filename    $ISO_NAME         "
info "   ISO Release     $VERSION          "
info "   Architecture    $ARCH             "
info "   Alpine version  $ALPINE_VER       "
info "   Kernel version  $KERNEL_VER       "
info

info
info "#####################################"
info "#       Package configuration       #"
info "#####################################"
info
info "TOOLS:"
info "$(echo "$TOOLS_PKGS" | xargs -n 5)"
info
info "NET:"
info "$(echo "$NET_PKGS" | xargs -n 5)"
info
info "XORG:"
info "$(echo "$XORG_PKGS" | xargs -n 5)"
info
info "XORG APPS:"
info "$(echo "$XAPPS_PKGS" | xargs -n 5)"
info
info "CUSTOM:"
info "$(echo "$CUSTOM_PKGS" | xargs -n 5)"
info

for run in scripts/*; do
    $run
done
