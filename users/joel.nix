{ pkgs, ... }:
{
  home-manager.users.joel = {
    imports = [
      ./profiles/common
      ./profiles/git
      ./profiles/shell
      ./profiles/packages/tools.nix
      ./profiles/ssh
      ./profiles/browser
      ./profiles/compositor
      ./profiles/editors/helix
      ./profiles/editors/vscode
      ./profiles/file-manager
      ./profiles/launcher
      ./profiles/notification-daemon
      ./profiles/terminal-emulator
      ./profiles/packages/apps.nix
      ./profiles/packages/code.nix
      ./profiles/window-manager
    ];

    programs.git = {
      enable = true;
      signing.key = "33CA5F24";
      signing.signByDefault = true;
      userEmail = "joel@joel.tokyo";
      userName = "Joel";
    };
  };

  users.users.joel = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "autologin" "docker" "ipfs" "wheel" ];
    shell = pkgs.fish;
  };
}
