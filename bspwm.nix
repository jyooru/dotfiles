{ config, pkgs, ... }:

{
  programs = {
    alacritty = { enable = true; };
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

  xsession.windowManager.bspwm.extraConfig = ''
    #! /bin/sh

    pgrep -x sxhkd > /dev/null || sxhkd &

    bspc monitor -d I II III IV V VI VII VIII IX X

    bspc config border_width         2
    bspc config window_gap          12

    bspc config split_ratio          0.52
    bspc config borderless_monocle   true
    bspc config gapless_monocle      true

    bspc rule -a Gimp desktop='^8' state=floating follow=on
    bspc rule -a Chromium desktop='^2'
    bspc rule -a mplayer2 state=floating
    bspc rule -a Kupfer.py focus=on
    bspc rule -a Screenkey manage=off'';

}
