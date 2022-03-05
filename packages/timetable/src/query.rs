use fuzzy_matcher::skim::SkimMatcherV2;
use fuzzy_matcher::FuzzyMatcher;

pub fn query_choice(choices: &Vec<String>, pattern: String) -> Option<usize> {
    let matcher = SkimMatcherV2::default();

    let mut scores = Vec::new();
    for choice in choices {
        scores.push(matcher.fuzzy_match(&choice, &pattern).unwrap_or(0))
    }

    let mut sorted_scores = scores.clone();
    sorted_scores.sort();
    let best_score = sorted_scores.last().unwrap_or(&0);

    for index in 0..scores.len() {
        if scores.get(index).unwrap_or(&0) == best_score {
            return Some(index);
        }
    }
    None
}
