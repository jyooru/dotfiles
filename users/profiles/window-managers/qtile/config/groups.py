from libqtile.config import Group


groups = [Group(i) for i in "12345678"] + [
    Group(
        "9",
        layout="spiral",
        spawn=[
            "sh -c 'sleep 2 && alacritty -e termusic'",
            "sh -c 'sleep 1 && alacritty -e btop -p 1'",
            "alacritty -e bandwhich -p",
        ],
    ),
    Group("0", layout="stack", spawn=["discord", "signal-desktop"]),
]
