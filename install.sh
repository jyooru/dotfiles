#!/usr/bin/env bash


configure_environment () {
  if [ -z "$1" ]; then
    if [ -d "/vscode/vscode-server" ]; then
      ask "environment: devcontainer"
      env="devcontainer"
      detail "automatically detected environment"
    else
      ask "environment:" "env"
    fi
  else
    env=$1
  fi
  environments=("laptop" "server" "devcontainer")
  for str in "${environments[@]}"; do
    if [ "$env" = "$str" ]; then
      return
    fi
  done
  error "please choose one of the following environments:"
  for environment in "${environments[@]}"; do
    detail "$environment"
  done
  output_details
  if [ -z "$1" ]; then
    configure_environment
  else
    exit 1
  fi
}


prepare_directories () {
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
  cd "$env" || error "could not cd into $env" "1"
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
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -s -y
  if [ "$env" = "devcontainer" ] ; then
      # TODO: refactor
      bash laptop/vscode/extensions.sh
      cat << "EOF" > "$HOME/.config/starship.toml"
[username]
show_always = true
style_user = "bold blue"
EOF
  fi
}


# output functions
section () {
  printf "\n%s\n" "$1"
}
spin () {
  local pid=$!
  local delay=0.1
  local animation="|/-\\"
  while [ -d "/proc/$pid" ]; do
    tput civis  # hide cursor
    end=${animation#?}
    animation=$end${animation%"$end"}
    printf "[%c] $1" "$animation"
    sleep $delay
    clear_line
  done
  success "$1"
  tput cnorm  # show cursor
}
success () {
  echo "[+] $1"
  output_details
}
error () {
  echo "[!] $1"
  output_details
  if [ -n "$2" ]; then
    exit "$2"
  fi
}
skip () {
  echo "[ ] $1"
  output_details
}
ask () {
  if [ -n "$2" ]; then
    read -rp "[?] $1 " "$2"
  else
    echo "[?] $1 "
  fi
  output_details
}
detail () {
  if ! [ "$details" == "" ]; then
    details="$details\n"
  fi
  details="$details - $1"
}
output_details () {
  if ! [ "$details" == "" ]; then
    printf "%b\n" "$details"
  fi
  details=""
}
clear_line () {
  printf "\r\033[1B"
}


main () {
  cat << "EOF"
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
EOF

  section "configuration"
  configure_environment "$1"

  section "preparation"
  prepare_directories

  section "installation"
  install
}


if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
  main "$@"
fi
