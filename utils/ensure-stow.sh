#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$dotfiles_dir/utils/install-pkg.sh"

ensure-stow () {
  if ! command -v stow > /dev/null; then
    install-pkg "stow"
  fi
}
