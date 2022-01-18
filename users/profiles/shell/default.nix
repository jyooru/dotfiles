{
  imports = [ ./abbrs.nix ./starship-nerd-fonts-symbols.nix ];

  programs = {
    fish = {
      enable = true;

      shellInit = ''
        set -gx EDITOR code --wait
        set -gx GIT_EDITOR nano

        set -g fish_greeting
        set -g fish_color_command normal --italics
        set -g fish_color_param normal
        set -g fish_color_valid_path brcyan --underline
      '';

      shellAliases = {
        "ls" = "lsd";
      };
    };

    starship.enable = true;
    zoxide.enable = true;
  };
}
