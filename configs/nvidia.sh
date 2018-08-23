#!/bin/bash
if (( $EUID != 0 )); then
	echo "This script has to be run as root"
	exit
fi

MAINDIR=$(pwd)

cp $MAINDIR/lightdm/* /etc/lightdm/

# disable bumblebee

systemctl disable bumblebeed.service

rm /etc/modprobe.d/bumblebee.conf
rm /etc/modprobe.d/bbswitch.conf

cp $MAINDIR/xorg/xorg-nvidia.conf /etc/X11/xorg.conf

eselect opengl set nvidia
