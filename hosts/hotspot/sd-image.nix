{ ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix>
  ];
  # put your own configuration here, for example ssh keys:
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    ../thinkpad-e580/id_rsa.pub
  ];
}
