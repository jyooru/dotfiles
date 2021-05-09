#!/usr/bin/bash

# dotfiles directory
DEFAULTDOTFILESDIR="$HOME/$DOTFILESDIR"
if [ -z "$DOTFILESDIR" ]; then
  export DOTFILESDIR="$DEFAULTDOTFILESDIR"
fi
if ! [ -d "$DOTFILESDIR" ]; then
  export DOTFIELSDIR="$DEFAULTDOTFILESDIR"
  if ! [ -d "$DOTFILESDIR" ]; then
    mkdir -p "$DOTFILESDIR"
  fi
fi

for file in {".aliases",".bashrc",".exports",".functions",".gitconfig",".profile"}; do
  ln -s "$DOTFILESDIR/$file" ~/$file
done
