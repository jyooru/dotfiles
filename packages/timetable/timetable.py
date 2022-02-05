from json import load
from pathlib import Path
from sys import argv

from fuzzywuzzy.fuzz import token_sort_ratio
from rich.box import SIMPLE_HEAVY
from rich.console import Console
from rich.table import Table


def generate_day_indexes():
    index = {}
    weeks = ["A", "B"]
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    for week in weeks:
        for day in days:
            index[str(len(index) + 1)] = f"Week {week} {day}"
    return index


def fuzzy_select(selection: str, options: dict[str, str]) -> str:
    matches = {
        index: token_sort_ratio(selection, option) for index, option in options.items()
    }
    matches_sorted = dict(sorted(matches.items(), key=lambda item: item[1]))
    match = list(matches_sorted.keys())[-1:][0]
    return match


def main() -> None:
    days = generate_day_indexes()
    day = fuzzy_select(" ".join(argv[1:]), generate_day_indexes())

    table = Table(box=SIMPLE_HEAVY, title=days[day], title_style="bold")

    table.add_column("Period", justify="center", style="bold green")
    table.add_column("Class", style="bold")
    table.add_column("Room", style="bold cyan")
    table.add_column("Teacher")

    with open(Path.home() / "school/timetable.json") as file:
        timetable = load(file)

    periods = {
        "5": "F",
        "6": "5",
        "7": "6",
    }

    for index, period in timetable[day].items():
        if index in periods:
            index = periods[index]

        table.add_row(
            index,
            period["name"],
            period["room"],
            period["teacher"],
        )

    console = Console()
    print()
    console.print(table)


if __name__ == "__main__":
    main()
