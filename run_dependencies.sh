#!/bin/sh


# Starship - https://starship.rs/
# Shell prompt
command -v starship >/dev/null 2>&1 || sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
