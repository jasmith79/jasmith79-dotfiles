#!/bin/bash
# Installs the Steam digital game delivery platform.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

os="$(bash $dotfiles_dir/utils/get-platform)"

if [ "$os" = "macos" ]; then
  exit 1
elif [ "$os" =~ "ubuntu" ]; then
  source "$dotfiles_dir/utils/update-apt.sh"
  update-apt
  sudo apt install steam -y
elif [ "$os" = "arch" ]; then
  exit 1
fi
