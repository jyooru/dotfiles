use crossterm::style::Stylize;
use fuzzy_matcher::skim::SkimMatcherV2;
use fuzzy_matcher::FuzzyMatcher;
use serde::{Deserialize, Serialize};
use std::env;
use std::fs;
use std::path::Path;
use tabled::Object;
use tabled::{
    Alignment, Column, Format, FormatFrom, Full, Header, Modify, Row, Style, Table, Tabled,
};

fn find_timetable() -> Option<String> {
    let home = env::var("HOME").unwrap();
    let paths = [
        ".config/timetable.json",
        "school/timetable.json",
        "timetable.json",
    ];

    for path in paths {
        let full_path = format!("{}/{}", home, path);
        if Path::new(&full_path).exists() {
            return Some(full_path);
        }
    }
    None
}

#[derive(Serialize, Deserialize, Tabled)]
struct Period {
    period: u8,
    name: String,
    room: String,
    teacher: String,
}
type Day = [Period; 7];
type Timetable = [Day; 10];

fn parse_timetable(timetable: String) -> Result<Timetable, serde_json::Error> {
    serde_json::from_str(&timetable)
}

fn get_choices() -> Vec<String> {
    let weeks = ['A', 'B'];
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

    weeks
        .map(|week| days.map(|day| format!("{} {}", day, week)))
        .concat()
}

fn get_pattern() -> String {
    let mut args: Vec<String> = env::args().collect();
    args.remove(0);
    args.join(" ")
}

pub fn query_choice(choices: &[String], pattern: String) -> usize {
    let matcher = SkimMatcherV2::default();
    let mut scores = Vec::new();
    for choice in choices {
        scores.push(matcher.fuzzy_match(choice, &pattern).unwrap_or(0))
    }

    let best_score = scores.iter().max().unwrap();
    for index in 0..scores.len() {
        if scores.get(index).unwrap() == best_score {
            return index;
        }
    }
    0
}

fn map_period(period: &str) -> String {
    let integer = period.parse::<u8>().unwrap();
    if integer == 5 {
        "F".to_string()
    } else if integer > 5 {
        (integer - 1).to_string()
    } else {
        integer.to_string()
    }
}

fn main() {
    let path = find_timetable().expect("Cannot find file");
    let file = fs::read_to_string(path).expect("Cannot read file");
    let timetable = parse_timetable(file).expect("Cannot parse file");

    let choices = get_choices();
    let choice = query_choice(&choices, get_pattern());

    let day = timetable.get(choice).unwrap();
    let header = &choices.get(choice).unwrap();
    let labels = ["Period", "Class", "Room", "Teacher"]
        .iter()
        .map(|s| s.bold().reset().to_string())
        .collect();

    let table = Table::new(day)
        .with(Modify::new(Full).with(Alignment::left()))
        // borders
        .with(Style::psql().vertical_off().header('━'))
        // header
        .with(Header(header))
        .with(Modify::new(Row(..1)).with(Format(|s| format!("{}\n", s).bold().reset().to_string())))
        // labels
        .with(Modify::new(Row(1..2)).with(FormatFrom(labels)))
        // columns
        .with(Modify::new(Column(..1).not(Row(..2))).with(Format(map_period)))
        .with(Modify::new(Column(..1)).with(Alignment::center_horizontal()))
        .with(Modify::new(Column(..1)).with(Format(|s| s.green().bold().to_string())))
        .with(Modify::new(Column(1..2)).with(Format(|s| s.bold().to_string())))
        .with(Modify::new(Column(2..3)).with(Format(|s| s.bold().cyan().to_string())));

    print!("\n{}", table)
}
