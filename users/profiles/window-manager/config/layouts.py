from libqtile import layout
from libqtile.config import Match

layout_defaults = dict(
    border_focus="#444444",
    border_normal="#303030",
    border_width=2,
    margin=6,
)

floating_layout = layout.Floating(
    float_rules=[*layout.Floating.default_float_rules], **layout_defaults
)

layouts = [
    layout.Columns(border_on_single=True, **layout_defaults),
    layout.RatioTile(**layout_defaults),
    layout.MonadTall(**layout_defaults),
    layout.MonadWide(**layout_defaults),
]
