{
  programs.alacritty = {
    enable = true;
    settings = {
      # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
      env = {
        WINIT_X11_SCALE_FACTOR = "1"; # fix font size not changing
      };
      window = {
        padding = {
          x = 25;
          y = 25;
        };
        dynamic_padding = true;
      };
      font = {
        normal = { family = "FiraCode Nerd Font"; };
        size = 11;
      };
      colors = {
        primary = {
          background = "#151515";
          foreground = "#E8E3E3";
        };
        normal = {
          black = "#151515";
          red = "#B66467";
          green = "#8C977D";
          yellow = "#D9BC8C";
          blue = "#8DA3B9";
          magenta = "#A988B0";
          cyan = "#8AA6A2";
          white = "#E8E3E3";
        };
        bright = {
          black = "#424242";
          red = "#B66467";
          green = "#8C977D";
          yellow = "#D9BC8C";
          blue = "#8DA3B9";
          magenta = "#A988B0";
          cyan = "#8AA6A2";
          white = "#E8E3E3";
        };
      };
    };
  };
}
