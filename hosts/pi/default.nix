{ inputs, ... }:
let
  path = inputs.nixpkgs.outPath + "/nixos/modules";
in
{
  imports = [
    (path + "/installer/sd-card/sd-image-raspberrypi.nix")
    (path + "/profiles/headless.nix")
    (path + "/profiles/minimal.nix")
  ];

  users.extraUsers.root.openssh.authorizedKeys.keys = [
    ../thinkpad-e580/id_rsa.pub
    ../galaxy-a22/com.termux/id_rsa.pub
  ];

  nixpkgs.crossSystem.system = "armv6l-linux";
}
