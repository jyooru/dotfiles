{ pkgs, ... }:
{
  # copy all config in this folder to ~/.config/qtile
  # `config.py` is still the entrypoint for qtile
  home.file.".config/qtile".source = ./.;

  home.packages = with pkgs; [ xsecurelock ];
}
