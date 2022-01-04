XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_BLANK_TIMEOUT=0 XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_FONT="FiraCode Nerd Font:style=Regular" xsecurelock &

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

hsetroot -solid "#1a1a1a"
killall polybar; polybar bar &

_start sxhkd
_start signal-desktop & _move_electron_app_to_desktop 0 Signal 3
_start .discord-wrappe discord & _move_electron_app_to_desktop 0 discord 
_start .spotify-wrappe spotify & _move_electron_app_to_desktop 9 Spotify