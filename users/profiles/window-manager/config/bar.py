from libqtile import widget
from libqtile.bar import Bar

widget_defaults = dict(
    font="FiraCode Nerd Font",
    fontsize=14,
    padding=4,
)

widgets = [
    widget.CurrentLayout(),
    widget.GroupBox(),
    widget.Prompt(),
    widget.WindowName(),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.TextBox("default config", name="default"),
    widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
    widget.Systray(),
    widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
    widget.Volume(),
    widget.QuickExit(),
]

bar = Bar(
    background="#1f1f1f",
    border_color="#303030",
    border_width=2,
    margin=[12, 12, 6, 12],
    size=28,
    widgets=widgets,
)
