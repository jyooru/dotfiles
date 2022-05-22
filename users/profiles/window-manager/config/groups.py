from libqtile.config import Group


groups = [Group(i) for i in "12345678"] + [
    Group("9", layout="stack", spawn=["spotify"]),
    Group("0", layout="stack", spawn=["discord", "signal-desktop"]),
]
