{ config, pkgs, ... }:

{
  programs = {
    alacritty = {
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
            background = "#1f1f1f";
            foreground = "#bbbbbb";
          };
          normal = {
            black = "#000000";
            red = "#cd3131";
            green = "#0dbc79";
            yellow = "#e5e510";
            blue = "#2472c8";
            magenta = "#bc3fbc";
            cyan = "#11a8cd";
            white = "#e5e5e5";
          };
          bright = {
            black = "#5c5c5c";
            red = "#f14c4c";
            green = "#23d18b";
            yellow = "#f5f543";
            blue = "#3b8eea";
            magenta = "#d670d6";
            cyan = "#29b8db";
            white = "#e5e5e5";
          };
        };
      };
    };
    rofi = { enable = true; };
  };

  services = {
    polybar = {
      enable = true;
      config = ./polybar.ini;
      script = "polybar bar &";
    };
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
        "super + {b,n}" = "{brave,obsidian}"; # launch apps
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
        "Print" = "scrot"; # screenshot all monitors
        "shift + Print" = "scrot --select --freze"; # select area and screenshot
        "control + Print" = "scrot --focused"; # screenshot current node

        # system
        "super + {_,alt + } Escape" = "betterlockscreen {--lock,--suspend}"; # lock
        "super + alt + {q,r}" = "bspc {quit,wm -r}"; # quit / restart bspwm

        # wm
        "super + alt + p" = "bspc config focus_follows_pointer {true,false}"; # toggle focus follows pointer
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
    };
    rules = { };
    extraConfig = ''
      monitors=(`bspc query -M --names`)
      if [ "''${#monitors[@]}" = "2" ]; then
        bspc monitor "''${monitors[0]}" -d 1 3 5 7 9
        bspc monitor "''${monitors[1]}" -d 2 4 6 8 0
      else
        bspc monitor "''${monitors[0]}" -d 1 2 3 4 5 6 7 8 9 0
      fi

      _start () {
        if ! pgrep -x "$1" > /dev/null; then
          if [ -z "$2" ]; then
            "$1" &
          else
            "$2" &
          fi
        fi
      }

      _get_desktop_index () { 
        desktops=(`bspc query -D --names`)
        wanted_desktop="$1"
        for i in "''${!desktops[@]}"; do
            if [[ "''${desktops[$i]}" = "''${wanted_desktop}" ]]; then
                wanted_desktop_index="''${i}"
            fi
        done
      }

      _move_electron_app_to_desktop () {
        [ -z "$3" ] && sleep="0.5" || sleep="$3"
        _get_desktop_index "$1" && sleep "$sleep" && wmctrl -r "$2" -t "''${wanted_desktop_index}"
      }

      xsetroot -solid "#1a1a1a"
      killall polybar; polybar bar &

      _start sxhkd
      _start signal-desktop & _move_electron_app_to_desktop 0 Signal 3
      _start .discord-wrappe discord & _move_electron_app_to_desktop 0 discord 
      _start .spotify-wrappe spotify & _move_electron_app_to_desktop 9 Spotify
    '';
  };
}
