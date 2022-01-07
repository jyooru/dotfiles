{ pkgs, ... }:
{
  services = {
    sxhkd = {
      enable = true;
      keybindings = {
        # desktops
        "alt + {_,shift +} Tab" = "bspc {desktop next.occupied -f, desktop prev.occupied -f}"; # switch desktops
        "super + {grave,Tab}" = "bspc {node,desktop} -f last"; # switch to previous node/desktop
        "super + {_,shift + }{0-9}" = "bspc {desktop -f,node -d} '{0-9}'"; # focus / send node to desktop;
        "super + control + {1-5}" = ''a=`expr {1-5} \* 2`; \
          b=`expr "$a" - 1`; \
          if [ "$a" = "10" ]; then a=0; fi; \
          bspc desktop -f "$b" & bspc desktop -f "$a"''; # focus two desktops (used with two monitors)

        # function buttons
        "XF86AudioMute" = "amixer set Master toggle"; # volume mute toggle
        "XF86AudioRaiseVolume" = "amixer set Master 10%+"; # volume up
        "XF86AudioLowerVolume" = "amixer set Master 10%-"; # volume down
        # XF86AudioMicMute
        "{_,shift + ,super + }XF86MonBrightness{Down,Up}" = "brightnessctl set {10%-,1%-,1%,10%+,1%+,100%}";
        # XF86Display
        # XF86WLAN
        # XF86Tools
        # XF86Bluetooth
        # ? (keyboard icon)
        # XF86Favourites
        "XF86AudioPrev" = "playerctl previous"; # previous song
        "XF86AudioPlay" = "playerctl play-pause"; # pause song
        "XF86AudioNext" = "playerctl next"; # next song

        # launch
        "super + space" = "rofi -combi-modi window,drun,ssh -show combi"; # launch launcher
        "super + {b,n}" = "{firefox,obsidian}"; # launch apps
        "super + {_,shift +} e" = "code {-r,-n}"; # launch editor
        "super + {t,Return}" = "alacritty"; # launch terminal
        "super + {r,c,s}" = "alacritty -e {ranger,cmatrix,htop}"; # launch terminal apps

        # nodes
        "super + {_,shift +} q" = "bspc node -{c,k}"; # close and kill
        "super + f" = "bspc node -t \~fullscreen"; # toggle node fullscreen
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}"; # focus / move node
        "super + ctrl + alt + {h,j,k,l}" = ''n=10; \
          { d1=left;   d2=right;  dx=-$n; dy=0;   \
          , d1=bottom; d2=top;    dx=0;   dy=$n;  \
          , d1=top;    d2=bottom; dx=0;   dy=-$n; \
          , d1=right;  d2=left;   dx=$n;  dy=0;   \
          } \
          bspc
          node - -resize $d1 $dx $dy || bspc node - -resize $d2 $dx $dy
        ''; # smart resize

        # screenshots
        "Print" = "cd ~/media/screenshots; scrot"; # screenshot all monitors
        "shift + Print" = "cd ~/media/screenshots; scrot --select --freeze"; # select area and screenshot
        "control + Print" = "cd ~/media/screenshots; scrot --focused"; # screenshot current node

        # system
        "super + {_,alt + } Escape" = ''XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_BLANK_TIMEOUT=0 XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_FONT="FiraCode Nerd Font:style=Regular" xsecurelock {_, & sleep 0.1 && systemctl suspend}''; # lock / and suspend
        "super + control + Escape" = "sleep 0.2 && xset s activate"; # turn off screen
        "super + alt + {q,r}" = "bspc {quit,wm -r}"; # quit / restart bspwm

        # wm
        "super + alt + p" = "bspc config focus_follows_pointer {false,true}"; # toggle focus follows pointer
      };
    };
  };

  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      normal_border_color = "#303030";
      active_border_color = "#303030";
      focused_border_color = "#444444";
      presel_feedback_color = "#444444"; # can't find what this is
      urgent_border_color = "#cd3131";

      border_width = 2;
      window_gap = 12;
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;

      focus_follows_pointer = true;
    };
    rules = { };
    extraConfig = builtins.readFile ./extra-config.sh;
  };

  home.packages = with pkgs; [ hsetroot ];
}
