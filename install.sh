#!/usr/bin/env bash


source install/certificate.sh


detect_env () {
  if [ -z "$1" ]; then
    if [ -d "/vscode/vscode-server" ]; then
      env="devcontainer"
    else
      echo -n "env="
      read -r env
    fi
  else
    env=$1
  fi
  for str in {"laptop","server","devcontainer"}; do
    if [ "$env" = "$str" ]; then
      return
    fi
  done
  echo "not a valid environment: $env"
  if [ -z "$1" ]; then
    detect_env
  else
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
  shopt -s dotglob # include hidden files
  cd "$env" || exit
  for file in *; do
    if [ -f "$file" ]; then
    echo "$file"
      if [ -L "$file" ]; then
        unlink "$dot_dst_dir/$file"
        echo "removed link for $file"
      else
        mv "$dot_dst_dir/$file" "$dot_bak_dir/$file"
        echo "$file has been backed up in $dot_bak_dir"
      fi
      ln -s "$dot_src_dir/$env/$file" "$dot_dst_dir/$file"
    elif [ -d "$file" ]; then
      echo "installing $file is not implemented"
    fi
    echo "installed $file"
  done
}


main () {
  detect_env "$1"
  dot_dirs
  install
  if [ "$env" = "devcontainer" ] ; then
    if needs_certificate; then
      install_certificate
    fi
  fi
}


main "$@"
