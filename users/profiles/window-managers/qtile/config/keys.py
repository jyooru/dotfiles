from shlex import quote

from libqtile.config import Key
from libqtile.lazy import lazy

from .groups import groups


mod = "mod4"
terminal = "alacritty"
lock = 'XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_BLANK_TIMEOUT=0 XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_FONT="FiraCode Nerd Font:style=Regular" xsecurelock'


def terminal_command(command: str) -> str:
    return f"alacritty -e {command}"


def sh(command: str):
    return lazy.spawn(f"sh -c {quote(command)}")


# https://docs.qtile.org/en/latest/manual/config/lazy.html
keys = [
    # Move focus
    Key(
        [mod],
        "h",
        lazy.layout.left(),
        desc="Move focus to left",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.right(),
        desc="Move focus to right",
    ),
    Key(
        [mod],
        "j",
        lazy.layout.down(),
        desc="Move focus down",
    ),
    Key(
        [mod],
        "k",
        lazy.layout.up(),
        desc="Move focus up",
    ),
    # Move windows
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up",
    ),
    # Grow windows
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down",
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        desc="Grow window up",
    ),
    # Layout functions
    Key(
        [mod],
        "z",
        lazy.layout.normalize(),
        desc="Reset all window sizes",
    ),
    Key(
        [mod],
        "x",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod],
        "Tab",
        lazy.next_layout(),
        desc="Toggle between layouts",
    ),
    # Window functions
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
    Key(
        [mod],
        "g",
        lazy.window.toggle_floating(),
        desc="Toggle floating",
    ),
    Key(
        [mod],
        "q",
        lazy.window.kill(),
        desc="Kill focused window",
    ),
    # Window manager functions
    Key(
        [mod, "mod1"],
        "r",
        lazy.restart(),
        desc="Restart Qtile",
    ),
    Key(
        [mod, "mod1"],
        "q",
        lazy.shutdown(),
        desc="Shutdown Qtile",
    ),
    # F* keys
    Key(
        [],
        "XF86AudioMute",
        sh("pamixer -t"),
        desc="Volume mute toggle",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        sh("pamixer -i 10"),
        desc="Volume up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        sh("pamixer -d 10"),
        desc="Volume down",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        sh("brightnessctl set 10%+"),
        desc="Brightness up",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        sh("brightnessctl set 10%-"),
        desc="Brightness down",
    ),
    # XF86AudioMicMute
    # XF86Display
    # XF86WLAN
    # XF86Tools
    # XF86Bluetooth
    # ? (keyboard icon)
    # XF86Favourites
    Key(
        [],
        "XF86AudioPrev",
        sh("playerctl previous"),
        desc="Previous song",
    ),
    Key(
        [],
        "XF86AudioPlay",
        sh("playerctl play-pause"),
        desc="Pause song",
    ),
    Key(
        [],
        "XF86AudioNext",
        sh("playerctl next"),
        desc="Next song",
    ),
    # Take screenshots
    Key(
        [],
        "Print",
        sh("cd ~/media/screenshots && scrot"),
        desc="Take screenshot",
    ),
    Key(
        ["shift"],
        "Print",
        sh("cd ~/media/screenshots && scrot --select --freeze"),
        desc="Take screenshot of a selected area",
    ),
    Key(
        ["control"],
        "Print",
        sh("cd ~/media/screenshots && scrot --focused"),
        desc="Take screenshot of focused window",
    ),
    # AFK
    Key(
        [mod],
        "Escape",
        sh(lock),
        desc="Lock screen",
    ),
    Key(
        [mod, "mod1"],
        "Escape",
        sh(f"{lock} & systemctl suspend"),
        desc="Lock screen and suspend",
    ),
    Key(
        [mod, "control"],
        "Escape",
        sh("sleep 0.2 && xset s activate"),
        desc="Turn screen off",
    ),
] + [
    # Launch programs
    Key([mod], key, sh(program), desc=f"Launch {program}")
    for key, program in {
        "Return": terminal,
        "space": "rofi -combi-modi window,drun,ssh -show combi",
        "b": "librewolf",
        "e": "pgrep code && code --new-window || code",
        "r": terminal_command("ranger"),
        "n": "obsidian",
    }.items()
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(toggle=True),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
