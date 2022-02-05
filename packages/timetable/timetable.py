from json import load
from pathlib import Path
from sys import argv

from fuzzywuzzy.fuzz import token_sort_ratio
from rich.box import SIMPLE_HEAVY
from rich.console import Console
from rich.table import Table

periods = {
    "5": "F",
    "6": "5",
    "7": "6",
}


def generate_day_indexes():
    indexes = {}
    weeks = ["A", "B"]
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    for week in weeks:
        for day in days:
            indexes[str(len(indexes) + 1)] = f"Week {week} {day}"
    return indexes


def fuzzy_select(selection: str, options: dict[str, str]) -> str:
    # rank
    matches = {i: token_sort_ratio(selection, option) for i, option in options.items()}
    # sort
    matches_sorted = dict(sorted(matches.items(), key=lambda item: item[1]))
    # get highest ranking
    match = list(matches_sorted.keys())[-1:][0]
    return match


def generate_timetable(title: str, data) -> Table:
    table = Table(box=SIMPLE_HEAVY, title=title, title_style="bold")

    table.add_column("Period", justify="center", style="bold green")
    table.add_column("Class", style="bold")
    table.add_column("Room", style="bold cyan")
    table.add_column("Teacher")

    for i, period in data.items():
        if i in periods:
            i = periods[i]

        table.add_row(
            i,
            period["name"],
            period["room"],
            period["teacher"],
        )


def main() -> None:
    with open(Path.home() / "school/timetable.json") as file:
        timetable = load(file)

    days = generate_day_indexes()
    day = fuzzy_select(" ".join(argv[1:]), days)
    table = generate_timetable(days[day], timetable[day])

    console = Console()
    print()
    console.print(table)


if __name__ == "__main__":
    main()
