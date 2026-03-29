#!/bin/sh

# Name scipt: replaced-grub.sh
# Copyright (c) Eat! Sleep! Linux Authors
# Script based on https://kowalski7cc.xyz/blog/systemd-boot-fedora-32 and https://github.com/peterwu/dotfiles/blob/master/install/fedora.org#replace-grub-with-systemd-boot
# Made by Georgii Bogdanov | gbog@proton.me

set -euxo pipefail

sudo mkdir /efi
sudo sed -i 's|/boot/efi|/efi|g' /etc/fstab
sudo systemctl daemon-reload
sudo umount /boot/efi
sudo umount /boot
sudo mount /efi
sudo mkdir /efi/$(cat /etc/machine-id)
sudo rm /etc/dnf/protected.d/{grub*,shim.conf}
sudo dnf remove -y grubby grub2\* memtest86\* && sudo rm -rf /boot/*
sudo dnf install -y systemd-boot-unsigned sdubby
sudo sed -i 's|/boot/efi|/efi|g' /etc/kernel/install.conf
sudo sed -i '5a layout=bls' /etc/kernel/install.conf
cat /proc/cmdline | cut -d ' ' -f 2- | sudo tee /etc/kernel/cmdline
sudo bootctl install --efi-boot-option-description="Fedora"
sudo kernel-install add $(uname -r) /lib/modules/$(uname -r)/vmlinuz
sudo dnf reinstall kernel-core
systemctl reboot
