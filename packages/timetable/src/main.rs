use std::env;
use std::fs;
use std::path::Path;

use tabled::Alignment;
use tabled::Column;
use tabled::Format;
use tabled::FormatFrom;
use tabled::Full;
use tabled::Header;
use tabled::Modify;
use tabled::Row;
use tabled::Style;
use tabled::Table;

use crossterm::style::Stylize;

mod parse;
mod query;

fn find_timetable() -> String {
    let home = env::var("HOME").unwrap();
    let paths = [
        ".config/timetable.json",
        "school/timetable.json",
        "timetable.json",
    ];

    for path in paths {
        let full_path = home.clone() + "/" + path;
        if Path::new(&full_path).exists() {
            return full_path;
        }
    }

    panic!("Could not find timetable.json");
}

fn get_pattern() -> String {
    let mut args: Vec<String> = env::args().collect();
    args.remove(0);
    args.to_vec().join(" ")
}

fn get_choices() -> Vec<String> {
    let weeks = ['A', 'B'];
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

    let mut choices: Vec<String> = Vec::new();
    for week in weeks {
        for day in days {
            choices.push(format!("{} {}", day, week));
        }
    }
    choices
}

fn main() {
    let file = fs::read_to_string(find_timetable()).expect("Cannot read file");
    let timetable = parse::parse_timetable(file);

    let choices = get_choices();
    let choice = query::query_choice(&choices, get_pattern()).expect("Fuzzy matching failed");

    let day = timetable.get(choice).unwrap();
    let table = Table::new(day)
        .with(Style::psql().vertical_off().header('━'))
        .with(Header(&choices.get(choice).unwrap()))
        .with(Modify::new(Row(..2)).with(Format(|s| s.bold().reset().to_string())))
        .with(Modify::new(Row(..1)).with(Format(|s| format!("{}\n", s))))
        .with(Modify::new(Row(1..2)).with(FormatFrom(vec![
            "Period".bold().reset().to_string(),
            "Class".bold().reset().to_string(),
            "Room".bold().reset().to_string(),
            "Teacher".bold().reset().to_string(),
        ])))
        .with(Modify::new(Full).with(Alignment::left()))
        .with(
            Modify::new(Column(..1))
                .with(Alignment::center_horizontal())
                .with(Format(|s| s.green().bold().to_string())),
        )
        .with(Modify::new(Column(1..2)).with(Format(|s| s.bold().to_string())))
        .with(Modify::new(Column(2..3)).with(Format(|s| s.bold().cyan().to_string())));

    println!("\n{}", table.to_string())
}
