#!/bin/sh
# sudo sh -c "$(curl -fsLS 192.168.0.10:8000/install-nixos-vm.sh)"


set -e


partition_disks () {
  parted /dev/vda -- mklabel gpt
  parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB
  parted /dev/vda -- set 1 esp on
  parted /dev/vda -- mkpart primary 512MiB -4096MiB
  parted /dev/vda -- mkpart primary linux-swap -4096MiB 100%
}

format_disks () {
  mkfs.fat -F 32 -n boot /dev/vda1
  mkfs.ext4 -L root /dev/vda2
  mkswap -L swap /dev/vda3
}


mount_disks () {
  mount /dev/disk/by-label/root /mnt
  mkdir -p /mnt/boot
  mount /dev/disk/by-label/boot /mnt/boot
  swapon /dev/disk/by-label/swap
}

prepare_disks () {
  partition_disks
  format_disks
  mount_disks
}


configure () {
  mkdir -p /mnt/etc/nixos
  curl --fail 192.168.0.10:8000/configuration.nix > /mnt/etc/nixos/configuration.nix || nixos-generate-config --force --root /mnt
}


install () {
  nixos-install
}

main () {
  [ -d /mnt/boot ] || prepare_disks

  # [ -e /mnt/etc/nixos/configuration.nix ] # always refresh from host
  curl --fail 192.168.0.10:8000/configuration.nix > /mnt/etc/nixos/configuration.nix || nixos-generate-config --root /mnt

  install
}


main
