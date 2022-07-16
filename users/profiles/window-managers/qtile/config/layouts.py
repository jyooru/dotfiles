from libqtile import layout

from .colors import base01, base02


layout_defaults = dict(
    border_focus=base02,
    border_normal=base01,
    border_width=2,
    margin=6,
)

floating_layout = layout.Floating(
    float_rules=[*layout.Floating.default_float_rules], **layout_defaults
)

layouts = [
    layout.Columns(border_on_single=True, **layout_defaults),
    layout.Spiral(**layout_defaults),
    layout.Stack(num_stacks=1, **layout_defaults),
    layout.RatioTile(**layout_defaults),
]
