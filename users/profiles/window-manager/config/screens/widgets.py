from libqtile import qtile, widget


background = "#1f1f1f"
background_alt = "#1a1a1a"
border = "#303030"
border_alt = "#444444"
foreground = "#bbbbbb"
foreground_alt = "#888888"
color = "#1a95e0"

u2006 = " "  # six-per-em space

widget_defaults = dict(
    foreground=foreground,
    font="FiraCode Nerd Font",
    fontsize=13,
    padding=12,
)


def bracket_wrap(*widgets, padding: int = 8, **kwargs) -> list:
    kwargs["padding"] = kwargs.get("padding", padding)
    return (
        [widget.TextBox("[", **kwargs)]
        + list(widgets)
        + [widget.TextBox("]", **kwargs)]
    )


widgets = (
    bracket_wrap(
        widget.GroupBox(
            active=foreground,
            borderwidth=2,
            disable_drag=True,
            highlight_color=[background, background],
            highlight_method="line",
            inactive=foreground_alt,
            margin_x=0,
            margin_y=4,
            rounded=False,
            other_current_screen_border=foreground_alt,
            other_screen_border=foreground_alt,
            padding_x=0,
            padding_y=0,
            this_current_screen_border=foreground_alt,
            this_screen_border=foreground_alt,
            spacing=6,
        )
    )
    + [
        widget.CurrentLayout(),
        widget.Spacer(),
        widget.Mpris2(
            display_metadata=["xesam:title", "xesam:artist"],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("playerctl previous"),
                "Button2": lambda: qtile.cmd_spawn("playerctl play-pause"),
                "Button3": lambda: qtile.cmd_spawn("playerctl next"),
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
        widget.Volume(fmt=" " + u2006 + "{}"),
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
