let
  nixpkgsConfig = ../../../profiles/common/nixpkgs.nix;
in

{
  programs.home-manager.enable = true;

  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  xdg.configFile."btop/btop.conf".text = ''
    clock_format = "/host"
    theme_background = False
  '';

  home.stateVersion = "21.11";
}
