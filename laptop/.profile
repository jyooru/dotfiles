#!/usr/bin/env bash


for path in {"$HOME/.local/bin","$HOME/.cargo/bin"}; do
  [ -d "$path" ] && PATH="$path:$PATH"
done
unset path


for file in ~/.{exports,aliases,functions}; do
  # shellcheck disable=SC1090
  [ -r "$file" ] && source "$file"
done
unset file

# configure histfile
HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=$HOME/.cache/histfile
HISTCONTROL=ignoreboth
