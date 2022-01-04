{ pkgs, ... }:
{
  services.polybar = {
    enable = true;
    settings = {
      "colors" = {
        background = "#1f1f1f";
        background-alt = "#1f1f1f";
        foreground = "#bbbbbb";
        foreground-alt = "#e5e5e5";
        primary = "#bbbbbb";
        secondary = "#303030";
        alert = "#bd2c40";
      };
      "bar/bar" = {
        monitor = ''''${env:MONITOR:eDP-1}'';
        width = "100%:-24";
        height = 28;
        offset = { x = 12; y = 12; };
        radius = 0;
        fixed-center = true;

        background = ''''${colors.background}'';
        foreground = ''''${colors.foreground}'';

        line = { color = "#f00"; size = 3; };

        border = { color = ''''${colors.secondary}''; size = 2; };

        padding = { left = 0; right = 2; };

        module-margin = { left = 2; right = 2; };

        font = [ "FiraCode Nerd Font:pixelsize=10;1" "unifont:fontformat=truetype:size=8:antialias=false;0" ];

        modules = {
          left = "bspwm";
          center = "playerctl";
          right = "alsa battery date powermenu";
        };

        tray = { position = "right"; padding = 2; };

        wm-restack = "bspwm";

        cursor = {
          click = "pointer";
          scroll = "ns-resize";
        };
      };
      "module/bspwm" = {
        type = "internal/bspwm";

        pin-workspaces = false;

        label = {
          focused = {
            text = "%name%";
            background = ''''${colors.background-alt}'';
            underline = ''''${colors.primary}'';
            padding = 1;
          };

          occupied = {
            text = "%name%";
            padding = 1;
          };

          urgent = {
            text = "%name%";
            background = ''''${colors.alert}'';
            padding = 1;
          };

          empty = {
            text = "%name%";
            foreground = ''''${colors.foreground-alt}'';
            padding = 1;
          };
        };
      };
      "module/playerctl" = {
        type = "custom/script";
        exec = pkgs.copyPathToStore ./playerctl-status.sh;
        interval = 1;
        click = {
          left = "playerctl previous &";
          right = "playerctl next &";
          middle = "playerctl play-pause &";
        };
      };
      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = {
          text = "";
          alt = " %Y-%m-%d";
        };
        time = {
          text = "%I:%M %P";
          alt = "%I:%M:%S %P";
        };
        format-prefix = {
          text = " ";
          foreground = ''''${colors.foreground-alt}'';
        };
        label = "%date% %time%";
      };
      "module/alsa" = {
        type = "internal/alsa";

        format = {
          volume = "<label-volume>";
          muted = { prefix = "婢  "; foreground = ''''${colors.foreground-alt}''; };
        };

        label = {
          volume = {
            text = "墳  %percentage%%";
            foreground = ''''${root.foreground}'';
          };
          muted = " 0%";
        };
      };
      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "ADP1";
        full-at = 100;
        format = {
          charging = "<animation-charging> <label-charging>";
          discharging = "<animation-discharging> <label-discharging>";
          full-prefix = {
            text = "  ";
            foreground = ''''${colors.foreground-alt}'';
          };
        };
        ramp-capacity = {
          text = [ "" "" "" "" "" "" "" "" "" ];
          foreground = ''''${colors.foreground-alt}'';
        };

        animation = {
          charging = {
            text = [ "" ];
            foreground = ''''${colors.foreground-alt}'';
            framerate = 750;
          };
          discharging = {
            text = [ "" ];
            foreground = ''''${colors.foreground-alt}'';
            framerate = 750;
          };
        };
      };

      settings.screenchange-reload = true;

      "global/wm".margin = { top = 0; bottom = 0; };
    };
    script = "polybar bar &";
  };
}
