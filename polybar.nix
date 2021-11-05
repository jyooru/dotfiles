{
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
    height = 27;
    offset-x = 12;
    offset-y = 12;
    radius = 0;
    fixed-center = true;

    background = ''''${colors.background}'';
    foreground = ''''${colors.foreground}'';

    line-size = 3;
    line-color = "#f00";

    border-size = 2;
    border-color = "#303030";

    padding-left = 0;
    padding-right = 2;

    module-margin-left = 2;
    module-margin-right = 2;

    font = [ "FiraCode Nerd Font:pixelsize=10;1" "unifont:fontformat=truetype:size=8:antialias=false;0" ];

    modules-left = "bspwm playerctl";
    modules-center = "hostname";
    modules-right = "alsa battery date powermenu";

    tray-position = "right";
    tray-padding = 2;

    wm-restack = "bspwm";

    cursor-click = "pointer";
    cursor-scroll = "ns-resize";
  };
  "module/bspwm" = {
    type = "internal/bspwm";

    pin-workspaces = false;

    label-focused = {
      text = "%name%";
      background = ''''${colors.background-alt}'';
      underline = ''''${colors.primary}'';
      padding = 1;
    };

    label-occupied = "%name%";
    label-occupied-padding = 1;

    label-urgent = "%name%";
    label-urgent-background = ''''${colors.alert}'';
    label-urgent-padding = 1;

    label-empty = "%name%";
    label-empty-foreground = ''''${colors.foreground-alt}'';
    label-empty-padding = 1;
  };
  "module/playerctl" = {
    type = "custom/script";
    exec = "~/code/repos/gh/jyooru/dotfiles/playerctl-status.sh";
    interval = 1;
    click-left = "playerctl previous &";
    click-right = "playerctl next &";
    click-middle = "playerctl play-pause &  ";
  };
  "module/hostname" = {
    type = "custom/script";
    exec = "echo `whoami`@`hostname`";
    interval = 60;

  };
  "module/date" = {
    type = "internal/date";
    interval = 5;
    date = "";
    date-alt = " %Y-%m-%d";
    time = "%I:%M %P";
    time-alt = "%I:%M:%S %P";
    format-prefix = " ";
    format-prefix-foreground = ''''${colors.foreground-alt}'';
    label = "%date% %time%";
  };
  "module/alsa" = {
    type = "internal/alsa";
    format-volume = "<label-volume>";
    label-volume = "墳  %percentage%%";
    label-volume-foreground = ''''${root.foreground}'';
    format-muted-prefix = "婢  ";
    format-muted-foreground = ''''${colors.foreground-alt}'';
    label-muted = " 0%";
  };
  "module/battery" = {
    type = "internal/battery";
    battery = "BAT0";
    adapter = "ADP1";
    full-at = 98;
    format-charging = "<animation-charging> <label-charging>";
    format-discharging = "<animation-discharging> <label-discharging>";
    format-full-prefix = "  ";
    format-full-prefix-foreground = ''''${colors.foreground-alt}'';
    ramp-capacity-0 = "";
    ramp-capacity-1 = "";
    ramp-capacity-2 = "";
    ramp-capacity-3 = "";
    ramp-capacity-4 = "";
    ramp-capacity-5 = "";
    ramp-capacity-6 = "";
    ramp-capacity-7 = "";
    ramp-capacity-8 = "";
    ramp-capacity-foreground = ''''${colors.foreground-alt}'';

    animation-charging-0 = "";
    animation-charging-foreground = ''''${colors.foreground-alt}'';
    animation-charging-framerate = 750;

    animation-discharging-0 = "";
    animation-discharging-foreground = ''''${colors.foreground-alt}'';
    animation-discharging-framerate = 750;
  };
  "module/powermenu" = {
    type = "custom/menu";

    expand-right = true;

    format-spacing = 1;

    label-open = "";
    label-open-foreground = ''''${colors.primary}'';
    label-close = "cancel";
    label-close-foreground = ''''${colors.primary}'';
    label-separator = " ";
    label-separator-foreground = ''''${colors.foreground-alt}'';

    menu-0-0 = "reboot";
    menu-0-0-exec = "menu-open-1";
    menu-0-1 = "power off";
    menu-0-1-exec = "menu-open-2";

    menu-1-0 = "cancel";
    menu-1-0-exec = "menu-open-0";
    menu-1-1 = "reboot";
    menu-1-1-exec = "sudo reboot";

    menu-2-0 = "power off";
    menu-2-0-exec = "sudo poweroff";
    menu-2-1 = "cancel";
    menu-2-1-exec = "menu-open-0";
  };
  settings.screenchange-reload = true;
  "global/wm".margin = { top = 0; bottom = 0; };
}


