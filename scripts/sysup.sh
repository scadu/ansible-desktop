#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt autoclean
sudo snap refresh

if [ -f /var/run/reboot-required.pkgs ]; then
    printf "Reboot required due to: \n\n"
    printf "%b\n" $(</var/run/reboot-required.pkgs)
fi
