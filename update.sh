#!/usr/bin/env bash


update_vscode () {
  file_path=run_vscode_extensions.sh
  printf "#!/bin/bash\n\n\n" > $file_path
  for extension in $(code --list-extensions); do
    echo "code --install-extension $extension" >> $file_path
  done
}

main () {
  update_vscode
}

main
