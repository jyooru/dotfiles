from libqtile.bar import Bar

from .widgets import widgets


bar = Bar(
    background="#1f1f1f",
    border_color="#303030",
    border_width=2,
    margin=[12, 12, 6, 12],
    size=28,
    widgets=widgets,
)
