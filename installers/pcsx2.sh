#!/bin/bash
# Installs the pcsx2 Playstation 2 emulator

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

os="$(bash $dotfiles_dir/utils/get-platform)"

if [ "$os" = "macos" ]; then
  exit 1
elif [ "$os" =~ "ubuntu" ]; then
  # Package in the universe repos is waaaay old
  sudo add-apt-repository ppa:pcsx2-team/pcsx2-daily
  sudo apt update
  sudo apt install pcsx2-unstable -y
elif [ "$os" = "arch" ]; then
  exit 1
fi