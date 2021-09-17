#!/bin/sh


update_vscode () {
  file_path=run_vscode_extensions.sh
  cat << "EOF" > "$file_path"
#!/bin/sh


if command -v code &> /dev/null; then
EOF
  for extension in $(code --list-extensions); do
    echo "  code --install-extension $extension" >> $file_path
  done
  echo "fi" >> $file_path
}

main () {
  update_vscode
}

main
