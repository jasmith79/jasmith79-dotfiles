#!/bin/bash
# Installs nodejs, npm, fnm, etc.
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$DOTFILES_DIR/utils/install-pkg.sh"

# Need rustup to install fnm
if ! command -v rustup > /dev/null; then
  source "$DOTFILES_DIR/installers/rust.sh"
fi

if ! command -v fnm > /dev/null; then
  # Specify actual path because it may not be on $PATH yet
  # if it just got installed
  ~/.cargo/bin/cargo install fnm
  eval "$(fnm env)"
fi

if ! command -v node > /dev/null; then
  install-pkg "nodejs"
fi

npm install -g yarn
npm install -g ts-node
