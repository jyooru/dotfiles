{
  imports = [ ./abbrs.nix ./starship-nerd-font-symbols.nix ];

  programs = {
    bat = {
      enable = true;
      config = {
        style = "plain";
      };
    };

    fish = {
      enable = true;

      shellInit = ''
        set -g fish_greeting
        set -g fish_color_command normal --bold
        set -g fish_color_param normal
        set -g fish_color_valid_path brcyan --underline
      '';

      shellAliases = {
        "ls" = "lsd";
      };
    };

    starship = {
      enable = true;
      settings = {
        # https://starship.rs/config/

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[>](bold red)";
        };

        cmd_duration.min_time = 10 * 1000;
      };
    };

    zoxide.enable = true;
  };
}
