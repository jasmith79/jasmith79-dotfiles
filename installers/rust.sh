#!/bin/bash

DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$DOTFILES_DIR/utils/install-pkg.sh"

if ! command -v curl > /dev/null; then
  install-pkg "curl"
fi

if ! command -v rustup > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  rustup install stable
  rustup default stable
fi
