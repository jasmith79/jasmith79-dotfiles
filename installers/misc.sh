#!/usr/bin/env bash
# Installs various packages I use.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$dotfiles_dir/utils/install-pkg.sh"

if ! command -v jq; then
  install-pkg jq
fi

if ! command -v htop; then
  install-pkg htop
fi

if ! command -v shellcheck; then
  install-pkg shellcheck
fi

if ! command -v zip; then
  install-pkg zip
fi

if ! command -v curl; then
  install-pkg curl
fi

if ! command -v fzf; then
  install-pkg fzf
fi

if ! command -v tree; then
  install-pkg tree
fi

if ! command -v neofetch; then
  install-pkg neofetch
fi
