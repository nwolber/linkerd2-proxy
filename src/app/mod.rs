use convert::TryFrom;
use logging;

pub mod config;
mod inbound;
mod main;
mod metric_labels;
mod outbound;

use self::config::{Config, Env};
pub use self::main::Main;

pub fn init() -> Result<Config, config::Error> {
    logging::init();
    let config_strings = Env;
    Config::try_from(&config_strings)
}