#!/bin/bash
# Copyright (c) Eat! Sleep! Linux Authors
# Script based on https://kowalski7cc.xyz/blog/systemd-boot-fedora-32 and https://github.com/peterwu/dotfiles/blob/master/install/fedora.org#replace-grub-with-systemd-boot

set -euxo pipefail

mkdir /efi
sed -i 's|/boot/efi|/efi|g' /etc/fstab
umount /boot/efi
mount /efi
mkdir /efi/$(cat /etc/machine-id)
rm /etc/dnf/protected.d/{grub*,shim.conf}
sudo dnf remove grubby grub2\* shim\* memtest86\ && sudo rm -rf /boot/grub2 && sudo rm -rf /boot/loader
cat /proc/cmdline | cut -d ' ' -f 2- | sudo tee /etc/kernel/cmdline
sudo bootctl install
sudo kernel-install add $(uname -r) /lib/modules/$(uname -r)/vmlinuz
sudo dnf reinstall kernel-core
systemctl reboot
