#!/usr/bin/env bash
# Installs nodejs, npm, fnm, etc.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$dotfiles_dir/utils/install-pkg.sh"

if ! command -v npm > /dev/null; then
    install-pkg node
fi

# Need rustup to install fnm
if ! command -v rustup > /dev/null; then
  source "$dotfiles_dir/installers/rust.sh" && source "$HOME/.cargo/env"
fi

if ! command -v fnm > /dev/null; then
  # Specify actual path because it may not be on $PATH yet
  # if it just got installed
  ~/.cargo/bin/cargo install fnm
  eval "$(fnm env)"
  ~/.cargo/bin/fnm use --install-if-missing 18 # current LTS
fi

if command -v update-node-global-pkgs > /dev/null; then
  update-node-global-pkgs
fi

