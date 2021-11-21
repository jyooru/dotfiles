# ga-z77-d3h

- **OS:** NixOS 21.05 (Okapi) x86_64
- **Kernel:** 5.10.79
- **Uptime:** 19 hours, 42 mins
- **Packages:** 565 (nix-system), 99 (nix-user)
- **Shell:** bash 4.4.23
- **Resolution:** 1920x1080
- **CPU:** Intel i7-3770 (8) @ 3.900GHz
- **GPU:** Intel HD Graphics
- **Memory:** 769MiB / 32008MiB

## Installation

```sh
# Create partitions on sda
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 1 esp on
parted /dev/sda -- mkpart primary 512MiB 100%

# Format sda2 and sdb for encryption
cryptsetup luksFormat /dev/sda2
cryptsetup luksFormat /dev/sdb

# Mount sda2 and sdb and create physical volumes
cryptsetup luksOpen /dev/sda2 crypt1
cryptsetup luksOpen /dev/sdb crypt2
pvcreate /dev/mapper/crypt1
pvcreate /dev/mapper/crypt2

# Create volume group with both physical volumes
vgcreate vg1 /dev/mapper/crypt1 /dev/mapper/crypt2

# Create logical volumes
lvcreate -n lv1 -L 4G vg1
lvcreate -n lv2 -l +100%FREE vg1

# Format logical volumes and partitions
mkfs.fat -n boot -F 32 /dev/sda1
mkswap -L swap /dev/mapper/vg1-lv1
mkfs.ext4 -L root /dev/mapper/vg1-lv2

# Activate or mount logical volumes and partitions
mount /dev/disk/by-label/root /mnt
mkdir -p /mnt/boot/efi
mount /dev/disk/by-label/boot /mnt/boot/efi
swapon /dev/disk/by-label/swap

# Generate configuration
nixos-generate-config --root /mnt
# Install configuration
nix-shell -p git nixFlakes
cd /mnt/etc
mv nixos nixos_
git clone https://github.com/jyooru/dotfiles.git nixos
cd nixos
nixos-install --flake .#ga-z77-d3h --impure # TODO: figure out why --impure is needed

# Installation complete!
reboot
```
