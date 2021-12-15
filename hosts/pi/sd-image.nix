{ config, pkgs, lib, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/profiles/minimal.nix>
    <nixpkgs/nixos/modules/installer/sd-card/sd-image.nix>
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.consoleLogLevel = lib.mkDefault 7;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  sdImage = {
    populateFirmwareCommands =
      let
        configTxt = pkgs.writeText "config.txt" ''
          # Prevent the firmware from smashing the framebuffer setup done by the mainline kernel
          # when attempting to show low-voltage or overtemperature warnings.
          avoid_warnings=1
          [pi0]
          kernel=u-boot-rpi0.bin
          [pi1]
          kernel=u-boot-rpi1.bin
        '';
      in
      ''
        (cd ${pkgs.raspberrypifw}/share/raspberrypi/boot && cp bootcode.bin fixup*.dat start*.elf $NIX_BUILD_TOP/firmware/)
        cp ${pkgs.ubootRaspberryPiZero}/u-boot.bin firmware/u-boot-rpi0.bin
        cp ${pkgs.ubootRaspberryPi}/u-boot.bin firmware/u-boot-rpi1.bin
        cp ${configTxt} firmware/config.txt
      '';
    populateRootCommands = ''
      mkdir -p ./files/boot
      ${config.boot.loader.generic-extlinux-compatible.populateCmd} -c ${config.system.build.toplevel} -d ./files/boot
    '';
  };

  # put your own configuration here, for example ssh keys:
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    ../thinkpad-e580/id_rsa.pub
  ];
}
