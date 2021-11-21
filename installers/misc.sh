#!/usr/bin/env bash
# Installs various packages I use.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$dotfiles_dir/utils/install-pkg.sh"

if ! command -v jq> /dev/null; then
  install-pkg jq
fi

if ! command -v htop> /dev/null; then
  install-pkg htop
fi

if ! command -v shellcheck> /dev/null; then
  install-pkg shellcheck
fi

if ! command -v zip> /dev/null; then
  install-pkg zip
fi

if ! command -v curl> /dev/null; then
  install-pkg curl
fi

if ! command -v fzf> /dev/null; then
  install-pkg fzf
fi

if ! command -v tree> /dev/null; then
  install-pkg tree
fi

if ! command -v neofetch> /dev/null; then
  install-pkg neofetch
fi
