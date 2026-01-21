#!/bin/bash/

sudo dnf install dnf-plugin-system-upgrade #Install plugin for full upgrade
sudo dnf system-upgrade download --releasever=43 #Upgrade to current Fedora Version
sudo dnf system-upgrade reboot #Reboot and upgrade on splash screen
