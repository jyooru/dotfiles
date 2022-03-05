use serde::{Deserialize, Serialize};
use tabled::Tabled;

#[derive(Serialize, Deserialize, Tabled)]
pub struct Period {
    period: u8,
    name: String,
    room: String,
    teacher: String,
}

pub type Day = [Period; 7];
pub type Timetable = [Day; 10];

pub fn parse_timetable(timetable: String) -> Timetable {
    serde_json::from_str(&timetable).expect("Cannot parse file")
}
