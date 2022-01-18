{ lib, pkgs, ... }:
{
  imports = [ ./keybindings.nix ./settings.nix ];

  programs.vscode = {
    enable = true;
    extensions = with lib; collect isDerivation (import ../../../packages { inherit pkgs; }).vscode-extensions;
  };
}
