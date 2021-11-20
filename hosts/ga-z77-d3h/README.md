# ga-z77-d3h

## Installation

### Storage

```sh
# Create partitions on sda
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
# parted /dev/sda -- mkpart linux-swap 512MiB 4608MiB
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
```
