{ lib, pkgs, ... }:
{
  imports = [ ./icons.nix ./keybindings.nix ./settings.nix ./theme.nix ];

  programs.vscode = {
    enable = true;
    extensions = with lib; collect isDerivation (import ../../../packages { inherit pkgs; }).vscode-extensions;
  };
}
