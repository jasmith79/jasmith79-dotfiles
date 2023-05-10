#!/bin/bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$dotfiles_dir/utils/ensure-stow.sh"

user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

mkdir -p ~/.old_configs

ensure-stow

pushd "$dotfiles_dir" || exit 1
stow -D wezterm
stow wezterm
popd || exit 1

