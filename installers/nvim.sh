#!/usr/bin/env bash
# jasmith79's install script for neovim. 

# This script is located inside a file named installers
# inside my dotfiles dir which should be inside $HOME
# for stow to work properly.
#
# This will grab the path to the dotfiles dir, quoting to
# guard against spaces in paths, e.g. I set my user name to
# "Jared Smith" or something.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
echo "Sourcing utils"
source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"
source "$dotfiles_dir/installers/vim.sh"

# Need python support for some stuff
if ! command -v pip3 > /dev/null; then
  echo "Installing python"
  source "$dotfiles_dir/installers/python.sh"
fi

# Need rust && c for tree-sitter
if ! command -v cargo > /dev/null; then
  echo "Installing rust"
  source "$dotfiles_dir/installers/rust.sh"
fi

if ! command -v gcc > /dev/null; then
  echo "installing gcc"
  "$dotfiles_dir/installers/cplus.sh"
fi

# need node.js for the TS/JS language servers
if ! command -v npm >/dev/null; then
  echo "installing node"
  "$dotfiles_dir/installers/node.sh"
fi

# Determine current user name
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

mkdir -p ~/.old_configs

# Install packer if not present
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

if ! command -v nvim > /dev/null; then
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install neovim
    sudo -u "$user" brew install tree-sitter
	sudo -u "$user" python3 -m pip install -U jedi-language-server

    sudo -u "$user" brew install lua-languague-server
    # The curl isn't working, just grabbing 0 bytes. TODO: fix. For now,
    # doin' it by hand.
    # pushd /tmp
    # curl -O https://github.com/artempyanykh/marksman/releases/download/2022-09-13/marksman-macos
    # chmod +x marksman-macos
    # mv marksman-macos /usr/local/bin/marksman
    # popd
  elif command -v apt > /dev/null; then
    # Official ubuntu repo version waaaay too old
    # for some of my plugins.
    # Can switch to stable once better treesitter/lsp
    # support lands.
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update && sudo apt install vim neovim -y
  else
    echo "Unrecognized platform, aborting nvim install"
    exit 1
  fi
fi

cargo install tree-sitter-cli

ensure-stow

pushd "$dotfiles_dir" || exit 1
stow -D nvim
stow nvim
popd || exit 1

