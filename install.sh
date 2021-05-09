#!/usr/bin/env bash

# dotfiles directories
DOT_DEFAULT_SRC_DIR="$HOME/.dotfiles"
if [ -z "$DOT_SRC_DIR" ]; then
  export DOT_SRC_DIR="$DOT_DEFAULT_SRC_DIR"
fi
if ! [ -d "$DOT_SRC_DIR" ]; then
  export DOT_SRC_DIR="$DOT_DEFAULT_SRC_DIR"
  if ! [ -d "$DOT_SRC_DIR" ]; then
    mkdir -p "$DOT_SRC_DIR"
  fi
fi
DOT_DST_DIR="$HOME"
DOT_BAK_DIR="$DOT_SRC_DIR/backup"
mkdir -p $DOT_BAK_DIR

# install
for file in {".aliases",".bashrc",".exports",".functions",".gitconfig",".profile"}; do
  if [ -L $file ]; then
    unlink "$DOT_DST_DIR/$file"
    echo "removed link for $file"
  elif [ -f $file ]; then
    mv "$DOT_DST_DIR/$file" "$DOT_BAK_DIR/$file"
    echo "$file has been backed up in $DOT_BAK_DIR"
  fi
  ln -s "$DOT_SRC_DIR/$file" "$DOT_DST_DIR/$file"
  echo "installed $file"
done
