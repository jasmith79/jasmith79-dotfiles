#!/bin/bash
# Ensures homebrew and cask are installed
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
