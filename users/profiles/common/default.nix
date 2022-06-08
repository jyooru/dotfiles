let
  nixpkgsConfig = ../../../profiles/common/nixpkgs.nix;
in

{
  home.stateVersion = "21.11";


  programs.home-manager.enable = true;

  nixpkgs.config = import nixpkgsConfig;
  xdg.configFile."nixpkgs/config.nix".source = nixpkgsConfig;

  xdg.configFile."btop/btop.conf".text = ''
    clock_format = "/host"
    theme_background = False
  '';
}
