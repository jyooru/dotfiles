{ lib, pkgs, ... }:

with lib;

{
  imports = [
    ./icons.nix
    ./keybindings.nix
    ./settings.nix
    ./theme.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = (collect
      isDerivation
      (pkgs.callPackage ../../../../overlays/vscode-extensions/sources.nix { })) ++ [
      pkgs.fenix.rust-analyzer-vscode-extension
    ];
  };
}
