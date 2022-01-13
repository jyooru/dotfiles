from libqtile.bar import Bar

from .widgets import background, border, widgets


bar = Bar(
    background=background,
    border_color=border,
    border_width=2,
    margin=[12, 12, 6, 12],
    size=28,
    widgets=widgets,
)
