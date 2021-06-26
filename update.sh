#!/usr/bin/env bash


. install.sh


update_vscode () {
  file_path=vscode/extensions.sh
  rm $file_path
  printf "#!/usr/bin/env bash\n\n\n" >> $file_path
  for extension in $(code --list-extensions)
  do
    echo "code --install-extension $extension" >> $file_path
  done
}

main () {
  cat << "EOF"
                 _       _             _     
 _   _ _ __   __| | __ _| |_ ___   ___| |__  
| | | | '_ \ / _` |/ _` | __/ _ \ / __| '_ \ 
| |_| | |_) | (_| | (_| | ||  __/_\__ \ | | |
 \__,_| .__/ \__,_|\__,_|\__\___(_)___/_| |_|
      |_|                                    
EOF
  section "configuration"
  configure_environment
  cd "${env:?}" || error "could not cd into ${env:?}" "1" # 
  
  section "update"
  if [ "${env:?}" == "laptop" ]; then
    update_vscode & spin "updating vscode extensions"
  fi
}

main
