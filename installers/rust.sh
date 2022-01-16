#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$dotfiles_dir/utils/install-pkg.sh"

# Need e.g. build-essential on Linux, easier to
# just grab all my C/C++ setup.
if ! command -v clang > /dev/null; then
  source "$dotfiles_dir/installers/cplus.sh"
fi

if ! command -v curl > /dev/null; then
  install-pkg "curl"
fi

if ! command -v rustup > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
  rustup install stable
  rustup default stable
fi
