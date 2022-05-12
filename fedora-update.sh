#!/bin/bash/

sudo dnf upgrade --refresh #Upgrade with update metadata
sudo dnf install dnf-plugin-system-upgrade #Install plugin for full upgrade
sudo dnf system-upgrade download --releasever=36 #Upgrade to current Fedora Version
sudo dnf system-upgrade reboot #Reboot and upgrade on splash screen
