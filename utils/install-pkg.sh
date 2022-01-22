#!/usr/bin/env bash
# Installs a package in a cross-platform way.
# I can't use this everywhere because sometimes
# either the package name is different on different
# platforms or I want to install slightly different
# packages depending on the platform but this
# works well enough.
os=$(uname)

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

# Ensure if on MacOS that we have homebrew
if [[ "$os" =~ [Dd]arwin ]]; then
  source "$dotfiles_dir/utils/ensure-brew.sh"
  ensure-brew
fi

install-pkg () {
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install "$@"
  elif command -v apt > /dev/null; then
    source "$dotfiles_dir/utils/update-apt.sh"
    update-apt
    sudo apt install "$@" -y
  else
    echo "Unable to install $1, unrecognized platform. Aborting..."
    exit 1
  fi
}
