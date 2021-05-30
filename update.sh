#!/usr/bin/env bash


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
  update_vscode
}

main
