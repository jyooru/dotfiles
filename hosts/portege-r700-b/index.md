---
layout: page
title: portege-r700-b
---

<img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi1.wp.com%2Fbiareview.com%2Fwp-content%2Fuploads%2F2017%2F05%2FToshiba-Portege-R700.png%3Ffit%3D629%252C372%26ssl%3D1&f=1&nofb=1" align="right" height="250px">

- **OS:** NixOS 21.05 (Okapi) x86_64
- **Host:** PORTEGE R700 PT311A-00J00Q
- **Kernel:** 5.10.79
- **Uptime:** 4 hours, 56 mins
- **Packages:** 566 (nix-system), 99 (nix-user)
- **Shell:** bash 4.4.23
- **Resolution:** 1366x768
- **CPU:** Intel i5 M 520 (4) @ 2.400GHz
- **GPU:** Intel Core Processor
- **Memory:** 388MiB / 3671MiB

## Installation

```sh
# Create partitions on sda
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 0% 2MiB
parted /dev/sda -- set 1 bios_grub on
parted /dev/sda -- mkpart primary 2MiB 100%
parted /dev/sda -- set 2 lvm on

# Format sda2 for encryption
cryptsetup luksFormat --type=luks1 /dev/sda2

# Mount sda2 and create physical volume
cryptsetup luksOpen /dev/sda2 crypt1
pvcreate /dev/mapper/crypt1

# Create volume group with physical volume
vgcreate vg1 /dev/mapper/crypt1

# Create logical volumes
lvcreate -n lv1 -L 4G vg1
lvcreate -n lv2 -l +100%FREE vg1

# Format logical volumes
mkswap -L swap /dev/mapper/vg1-lv1
mkfs.ext4 -L root /dev/mapper/vg1-lv2

# Activate or mount logical volumes
mount /dev/disk/by-label/root /mnt
swapon /dev/disk/by-label/swap

# Generate configuration
nixos-generate-config --root /mnt
# Install configuration
nix-shell -p git nixFlakes
cd /mnt/etc
mv nixos nixos_
git clone https://github.com/jyooru/dotfiles.git nixos
cd nixos
nixos-install --flake .#portege-r700-b --impure

# Installation complete!
reboot
```
