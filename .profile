# add directories to path if they exist
for path in {"$HOME/.local/bin","$HOME/code/scripts"}; do
  [ -d "$path" ] && PATH="$path:$PATH"
done
unset path

# source from files if they exist
for file in ~/.{exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# configure histfile
HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=$HOME/.cache/histfile
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
