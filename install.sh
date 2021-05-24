#!/usr/bin/env bash


detect_env () {
  if [ -d "/vscode/vscode-server" ]; then
    env="devcontainer"
  else
    echo -n "env="
    read -r env
    for str in {"laptop","server"}; do
      if [ "$env" = "$str" ]; then
        return
      fi
    done
    echo "not a valid environment: $env"
    exit 1
  fi
}


dot_dirs () {
  dot_default_src_dir="$HOME/.dotfiles"
  if [ -z "$dot_src_dir" ]; then
    dot_src_dir="$dot_default_src_dir"
  fi
  if ! [ -d "$dot_src_dir" ]; then
    dot_src_dir="$dot_default_src_dir"
    if ! [ -d "$dot_src_dir" ]; then
      mkdir -p "$dot_src_dir"
    fi
  fi
  dot_dst_dir="$HOME"
  dot_bak_dir="$dot_src_dir/backup"
  mkdir -p "$dot_bak_dir"
}


install () {
  for file in {".aliases",".bashrc",".exports",".functions",".gitconfig",".profile"}; do
    if [ -L "$file" ]; then
      unlink "$dot_dst_dir/$file"
      echo "removed link for $file"
    elif [ -f "$file" ]; then
      mv "$dot_dst_dir/$file" "$dot_bak_dir/$file"
      echo "$file has been backed up in $dot_bak_dir"
    fi
    ln -s "$dot_src_dir/$file" "$dot_dst_dir/$file"
    echo "installed $file"
  done
}


main () {
  dot_dirs
  install
}


main
