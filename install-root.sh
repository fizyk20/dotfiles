#!/bin/bash
if (( $EUID != 0 )); then
	echo "This script has to be run as root"
	exit
fi

MAINDIR=$(pwd)

cp $MAINDIR/lightdm/* /etc/lightdm/
