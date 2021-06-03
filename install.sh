#!/usr/bin/env bash


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
  for str in {"laptop","server","devcontainer","certificate"}; do
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


needs_certificate () {
  page="$(curl -Lks localnetwork.zone)"
  if [[ $page == *"Incorrectly configured DNS"* ]]; then
    return 1
  else
    return 0
  fi
}


install_certificate () {
  # devcontainer (alpine)
  download_link="https://cert.localnetwork.zone/noauth/cacert"
  save_tmp="/tmp/crt"
  save_loc="/usr/local/share/ca-certificates/extra/certlocalnetworkzone.crt"

  mkdir -p "$(dirname $save_tmp)"
  curl -Lk $download_link -o $save_tmp
  sudo mkdir -p "$(dirname $save_loc)"
  sudo mv $save_tmp $save_loc
  sudo update-ca-certificates
}


if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
  if needs_certificate; then
    install_certificate
  fi
fi

# output functions
section () {
  echo "$1"
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
    printf "\r\033[1B"
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
}
skip () {
  echo "[ ] $1"
  output_details
}
ask () {
  read -rp "[?] $1 " "$2"
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


main () {
  cat << "EOF"
     _       _    __ _ _           
  __| | ___ | |_ / _(_) | ___  ___ 
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/

EOF
  detect_env "$1"
  if [ "$env" = "certificate" ]; then
    install_certificate
  else
    dot_dirs
    install
    if [ "$env" = "devcontainer" ] ; then
      if needs_certificate; then
        install_certificate
      fi
    fi
  fi
}


main "$@"
