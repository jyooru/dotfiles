# portege-z930

- **OS:** NixOS 21.05 (Okapi) x86_64
- **Host:** PORTEGE Z930 PT234A-07T058
- **Kernel:** 5.10.79
- **Uptime:** 7 hours, 25 mins
- **Packages:** 565 (nix-system), 99 (nix-user)
- **Shell:** bash 4.4.23
- **Resolution:** 1366x768
- **CPU:** Intel i5-3337U (4) @ 2.700GHz
- **GPU:** Intel 3rd Gen Core processor Graphics Controller
- **Memory:** 400MiB / 5842MiB

## Installation

```sh
# Create partitions on sda
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- set 1 esp on
parted /dev/sda -- mkpart primary 512MiB 100%

# Format sda2 for encryption
cryptsetup luksFormat /dev/sda2

# Mount sda2 and create physical volume
cryptsetup luksOpen /dev/sda2 crypt1
pvcreate /dev/mapper/crypt1

# Create volume group with physical volume
vgcreate vg1 /dev/mapper/crypt1

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
nixos-install --flake .#portege-z930 --impure # TODO: figure out why --impure is needed

# Installation complete!
reboot
```
