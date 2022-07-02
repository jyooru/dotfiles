from subprocess import SubprocessError

from libqtile import qtile, widget

from ..colors import base00, base03, base04, base08


u2006 = " "  # six-per-em space

widget_defaults = dict(
    foreground=base04,
    font="FiraCode Nerd Font",
    fontsize=13,
    padding=12,
)


def bracket_wrap(*widgets, padding: int = 8, **kwargs) -> list:
    return (
        [widget.TextBox("[", padding=padding, **kwargs)]
        + list(widgets)
        + [widget.TextBox("]", padding=padding, **kwargs)]
    )


class Volume(widget.Volume):
    def get_volume(self) -> int:
        try:
            self.call_process(["pamixer", "--get-mute"])
            return -1  # is muted
        except SubprocessError:
            pass

        try:
            return int(self.call_process(["pamixer", "--get-volume"]))
        except SubprocessError:
            return -1


widgets = (
    bracket_wrap(
        widget.GroupBox(
            active=base04,
            borderwidth=2,
            disable_drag=True,
            highlight_color=[base00, base00],
            highlight_method="line",
            inactive=base03,
            margin_x=0,
            margin_y=4,
            rounded=False,
            other_current_screen_border=base04,
            other_screen_border=base04,
            padding_x=0,
            padding_y=0,
            spacing=6,
            this_current_screen_border=base04,
            this_screen_border=base04,
            urgent_border=base08,
        )
    )
    + [
        widget.CurrentLayout(),
        widget.Spacer(),
        widget.Mpris2(
            display_metadata=["xesam:title", "xesam:artist"],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    "playerctl --player spotify previous"
                ),
                "Button2": lambda: qtile.cmd_spawn(
                    "playerctl --player spotify play-pause"
                ),
                "Button3": lambda: qtile.cmd_spawn("playerctl --player spotify next"),
            },
            name="spotify",
            objname="org.mpris.MediaPlayer2.spotify",
            scroll_chars=80,
            scroll_interval=1 / 4,
            # wait 1 hour before hiding a song that is playing, for some reason
            scroll_wait_intervals=60 * 60 * 4,
            stop_pause_text="",
        ),
        widget.Spacer(),
        # widget.CPU(format=" " + u2006 + "{load_percent}% @ {freq_current}GHz"),
        # widget.Net(format=" " + u2006 + " {down}  {up}"),
        Volume(fmt=" " + u2006 + "{}"),
        widget.Battery(
            charge_char="",
            discharge_char="",
            empty_char="",
            full_char="",
            unknown_char="",
            format="{char} {percent:2.0%}: {hour:d}:{min:02d}",  # no u+2006 on purpose
            show_short_text=False,
        ),
        widget.Clock(format=" " + u2006 + "%I:%M %P"),
    ]
    + bracket_wrap(widget.Systray(padding=0))
)
