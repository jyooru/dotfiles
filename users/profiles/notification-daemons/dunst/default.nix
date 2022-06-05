{
  services.dunst = {
    enable = true;
    settings = {
      # https://dunst-project.org/documentation/

      global = {
        background = "#151515";
        foreground = "#BBB6B6";
        font = "FiraCode Nerd Font 11";
        frame_width = 2;
        icon_position = "off";
        ignore_dbusclose = true;
        offset = "24x68"; # 12x56
        show_indicators = false;
        width = "225";
      };

      urgency_low = { frame_color = "#1F1F1F"; timeout = 5; };
      urgency_normal = { frame_color = "#2E2E2E"; timeout = 5; };
      urgency_critical.frame_color = "#B66467";
    };
  };
}
