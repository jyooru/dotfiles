from libqtile.bar import Bar

from ..colors import base00, base01
from .widgets import widgets


bar = Bar(
    background=base00,
    border_color=base01,
    border_width=2,
    margin=[12, 12, 6, 12],
    size=28,
    widgets=widgets,
)
