{
  services.dunst = {
    enable = true;
    settings = {
      # https://dunst-project.org/documentation/

      global = {
        background = "#1f1f1f";
        foreground = "#bbbbbb";
        font = "FiraCode Nerd Font 11";
        frame_width = 2;
        icon_position = "off";
        ignore_dbusclose = true;
        offset = "24x68"; # 12x56
        show_indicators = false;
        width = "225";
      };

      urgency_low = { frame_color = "#303030"; timeout = 5; };
      urgency_normal = { frame_color = "#444444"; timeout = 5; };
      urgency_critical.frame_color = "#ff0000";
    };
  };
}
