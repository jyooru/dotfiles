from libqtile.config import Group, Match


groups = [Group(i) for i in "12345678"] + [
    Group(
        "9",
        exclusive=True,
        layout="stack",
        matches=[
            Match(wm_instance_class="spotify"),
        ],
        spawn=["spotify"],
    ),
    Group(
        "0",
        exclusive=True,
        layout="stack",
        matches=[
            Match(wm_instance_class="discord"),
            Match(wm_instance_class="signal"),
        ],
        spawn=["discord", "signal-desktop"],
    ),
]
