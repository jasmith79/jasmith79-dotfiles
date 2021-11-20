#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

# NOTE: sourcing this ensures homebrew on macos
source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/update-apt.sh"

os=$(bash "$dotfiles_dir/utils/get-platform")

if [[ "$os" =~ "ubuntu" ]]; then
  update-apt
  sudo apt install openjdk-8-jdk
  sudo apt install openjdk-11-jdk
elif [ "$os" = "macos" ]; then
  brew tap adoptopenjdk/openjdk
  brew cask install adoptopenjdk8
  brew cask install adoptopenjdk11
elif [ "$os" = "arch" ]; then
  echo "Not implemented yet!" >&2
  exit 1
else
  echo "Unsupported platform $os, aborting!" >&2
  exit 1
fi

install-pkg maven
