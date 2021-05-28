#!/usr/bin/env bash


needs_certificate () {
  page="$(curl -Lk --no-progress-meter localnetwork.zone)"
  if [[ $page == *"Incorrectly configured DNS"* ]]; then
    return 0
  else
    return 1
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
