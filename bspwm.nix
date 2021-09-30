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
      script = "polybar bar &";
    };
    sxhkd = {
      enable = true;
      extraConfig = ''
        super + Return
          alacritty

        # reload sxhkd
        super + Escape
          pkill -USR1 -x sxhkd

        # quit / restart bspwm
        super + alt + {q,r}
          bspc {quit,wm -r}

        # close and kill
        super + {_,shift + } q
          bspc node -{c,k}

        # Switch Active Workspaces
        alt + {Tab, shift + Tab}
          bspc {desktop next.occupied -f, desktop prev.occupied -f}

        # focus the last node/desktop
        super + {grave,Tab}
          bspc {node,desktop} -f last

        super + f
          bspc node -t \~fullscreen

        # focus or send to the given desktop
        super + {_,shift + }{0-9}
          bspc {desktop -f,node -d} '{0-9}'

        super + control + {1-5}
          a=`expr {1-5} \* 2`; \
          b=`expr "$a" - 1`; \
          if [ "$a" = "10" ]; then a=0; fi; \
          bspc desktop -f "$b" & bspc desktop -f "$a"
          
        super + space
          rofi -combi-modi window,drun,ssh -show combi

        XF86Audio{Prev,Next}
        	mpc -q {prev,next}

        @XF86LaunchA
        	scrot -s -e 'image_viewer $f'

        super + shift + equal
        	sxiv -rt "$HOME/image"

        XF86LaunchB
        	xdotool selectwindow | xsel -bi

        super + {h,j,k,l}
        	bspc node -f {west,south,north,east}

        super + alt + {0-9}
        	mpc -q seek {0-9}0%

        super + {alt,ctrl,alt + ctrl} + XF86Eject
        	sudo systemctl {suspend,reboot,poweroff}

        super + {_,shift + }{h,j,k,l}
        	bspc node -{f,s} {west,south,north,east}

        {_,shift + ,super + }XF86MonBrightness{Down,Up}
        	bright {-1,-10,min,+1,+10,max}

        super + o ; {e,w,m}
        	{gvim,firefox,thunderbird}

        super + alt + control + {h,j,k,l} ; {0-9}
        	bspc node @{west,south,north,east} -r 0.{0-9}

        super + alt + p
        	bspc config focus_follows_pointer {true,false}

        # Smart resize, will grow or shrink depending on location.
        # Will always grow for floating nodes.
        super + ctrl + alt + {Left,Down,Up,Right}
          n=10; \
          { d1=left;   d2=right;  dx=-$n; dy=0;   \
          , d1=bottom; d2=top;    dx=0;   dy=$n;  \
          , d1=top;    d2=bottom; dx=0;   dy=-$n; \
          , d1=right;  d2=left;   dx=$n;  dy=0;   \
          } \
          bspc node --resize $d1 $dx $dy || bspc node --resize $d2 $dx $dy
      '';
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

      _start sxhkd
      _start signal-desktop & _move_electron_app_to_desktop 0 Signal 3
      _start .discord-wrappe discord & _move_electron_app_to_desktop 0 discord 
      _start .spotify-wrappe spotify & _move_electron_app_to_desktop 9 Spotify
    '';
  };
}
