#!/bin/bash
if (( $EUID != 0 )); then
	echo "This script has to be run as root"
	exit
fi

MAINDIR=$(pwd)

rm /etc/lightdm/*.sh
cp $MAINDIR/lightdm/bbswitch/* /etc/lightdm/

# xorg.conf unnecessary and might be left over from other experiments

if [ -f "/etc/X11/xorg.conf" ]; then
	rm /etc/X11/xorg.conf
fi

# enable bumblebee

systemctl enable bumblebeed.service

echo "blacklist nvidia" > /etc/modprobe.d/bumblebee.conf
echo "blacklist nvidia-drm" >> /etc/modprobe.d/bumblebee.conf
echo "blacklist nvidia-modeset" >> /etc/modprobe.d/bumblebee.conf
echo "blacklist nvidia-uvm" >> /etc/modprobe.d/bumblebee.conf
echo "blacklist nouveau" >> /etc/modprobe.d/bumblebee.conf

# configure bbswitch

echo "options bbswitch load_state=0 unload_state=1" > /etc/modprobe.d/bbswitch.conf

eselect opengl set xorg-x11
