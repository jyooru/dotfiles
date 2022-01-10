from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from .groups import groups


mod = "mod4"
terminal = "alacritty"
lock = 'XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_BLANK_TIMEOUT=0 XSECURELOCK_PASSWORD_PROMPT=asterisks XSECURELOCK_FONT="FiraCode Nerd Font:style=Regular" xsecurelock'


def terminal_command(command: str) -> str:
    return f"alacritty -e {command}"


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "mod1"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "mod1"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # media
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer set Master toggle"),
        desc="Volume mute toggle",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("amixer set Master 10%+"),
        desc="Volume up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("amixer set Master 10%-"),
        desc="Volume down",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set 10%+"),
        desc="Brightness up",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 10%-"),
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
        lazy.spawn("playerctl previous"),
        desc="Previous song",
    ),
    Key(
        [],
        "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="Pause song",
    ),
    Key(
        [],
        "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc="Next song",
    ),
    # screenshots
    Key(
        [],
        "Print",
        lazy.spawn("cd ~/media/screenshots && scrot"),
        desc="Take screenshot",
    ),
    Key(
        ["shift"],
        "Print",
        lazy.spawn("cd ~/media/screenshots && scrot --select --freeze"),
        desc="Take screenshot of a selected area",
    ),
    Key(
        ["control"],
        "Print",
        lazy.spawn("cd ~/media/screenshots && scrot --focused"),
        desc="Take screenshot of focused window",
    ),
    # afk
    Key(
        [mod],
        "Escape",
        lazy.spawn(lock),
        desc="Lock screen",
    ),
    Key(
        [mod, "mod1"],
        "Escape",
        lazy.spawn(f"{lock} && sleep 0.5 && systemctl suspend"),
        desc="Lock screen",
    ),
    Key(
        [mod, "control"],
        "Escape",
        lazy.spawn("sleep 0.2 && xset s activate"),
        desc="Turn screen off",
    ),
] + [
    Key([mod], key, lazy.spawn(program), desc=f"Launch {program}")
    for key, program in {
        "Return": terminal,
        "space": "rofi -combi-modi window,drun,ssh -show combi",
        "b": "firefox",
        "e":"code --new-window",
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
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )
