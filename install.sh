#!/usr/bin/env bash

# dotfiles directory
DOT_DEFAULT_DIR="$HOME/$DOT_DIR"
if [ -z "$DOT_DIR" ]; then
  export DOT_DIR="$DOT_DEFAULT_DIR"
fi
if ! [ -d "$DOT_DIR" ]; then
  export DOT_DIR="$DOT_DEFAULT_DIR"
  if ! [ -d "$DOT_DIR" ]; then
    mkdir -p "$DOT_DIR"
  fi
fi

for file in {".aliases",".bashrc",".exports",".functions",".gitconfig",".profile"}; do
  ln -s "$DOT_DIR/$file" ~/$file
done
