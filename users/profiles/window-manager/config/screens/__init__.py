from libqtile.bar import Gap
from libqtile.config import Screen

from .bar import bar
from .widgets import widget_defaults


__all__ = [
    "bar",
    "screens",
    "widget_defaults",
]


gap = Gap(6)

screen_defaults = dict(
    wallpaper="~/media/wallpapers/1a1a1a.png",
    wallpaper_mode="stretch",
    bottom=gap,
    left=gap,
    right=gap,
)

screens = [
    Screen(top=bar, **screen_defaults),
    Screen(top=gap, **screen_defaults),
]
