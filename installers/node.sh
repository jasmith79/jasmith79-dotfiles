#!/bin/bash
# Installs nodejs, npm, fnm, etc.
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$DOTFILES_DIR/utils/install-pkg.sh"

# Need rustup to install fnm
source "$DOTFILES_DIR/installers/rust.sh"

# Specify actual path because it may not be on $PATH yet
~/.cargo/bin/cargo install fnm

eval "$(fnm env)"

if ! command -v node > /dev/null; then
  install-pkg "nodejs"
fi

npm install -g yarn
npm install -g ts-node
