{ config, lib, pkgs, ... }:

with lib;

let
  inherit ((import ../../terminal-emulators/alacritty).programs.alacritty.settings) colors;

  config = recursiveUpdate
    (importTOML ./defaults.toml)
    {
      disable_exit_confirmation = true;
      loop_mode = "Playlist"; # manual clear
      music_dir = "~/media/music";
      volume = 100;
      style_color_symbol = {
        alacritty_theme = colors.primary // colors.normal // (mapAttrs'
          (name: value: {
            name = "light_${name}";
            inherit value;
          })
          colors.bright) // {
          cursor = colors.primary.foreground;
          text = colors.primary.background;
        };

        library_border = "White";
        library_highlight = "Cyan";
        library_highlight_symbol = "";

        lyric_border = "White";
        lyric_foreground = "White";

        playlist_border = "White";
        playlist_highlight = "Cyan";
        playlist_highlight_symbol = "";

        progress_border = "White";
        progress_foreground = "Green";
      };
    };
  toml = pkgs.formats.toml { };
in

{
  home.packages = [ pkgs.termusic ];
  xdg.configFile."termusic/config.toml".source = toml.generate "config.toml" config;
}
