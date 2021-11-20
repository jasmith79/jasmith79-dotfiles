#!/usr/bin/env bash
# Ensures homebrew and cask are installed
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
user=$(bash "$dotfiles_dir/utils/better-whoami")
ensure-brew () {
  if ! command -v brew >/dev/null; then
    sudo -u "$user" /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if ! brew info brew-cask &>/dev/null; then
    brew tap homebrew/cask-versions
    brew update
    brew tap caskroom/cask
  fi
}
