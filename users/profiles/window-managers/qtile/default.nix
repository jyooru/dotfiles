{ pkgs, ... }:
{
  home = {
    # copy all config in this folder to ~/.config/qtile
    # `config.py` is still the entrypoint for qtile
    file.".config/qtile".source = ./.;

    packages = with pkgs; [ xsecurelock ];
  };
}
