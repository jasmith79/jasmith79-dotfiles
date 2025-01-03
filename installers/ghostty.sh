#!/bin/bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os="$(bash "$dotfiles_dir/utils/get-platform")"
source "$dotfiles_dir/utils/ensure-brew.sh"
source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"

user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

ensure-stow

if ! command -v ghostty >/dev/null; then
  if [ "$os" = "Darwin" ]; then
    ensure-brew
    brew install --cask ghostty
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

pushd "$dotfiles_dir" || exit 1
stow -D ghostty
stow ghostty
popd || exit 1
