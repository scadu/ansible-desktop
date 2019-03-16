#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt autoclean

if [ -f /var/run/reboot-required.pkgs ]; then
    printf "Reboot required due to: \n\n"
    printf "%s" $(</var/run/reboot-required.pkgs)
fi
