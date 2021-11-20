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

source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/installers/vim.sh"

# Need python support for some stuff
if ! command -v pip3 > /dev/null; then
  source "$dotfiles_dir/installers/python.sh"
fi

# Need rust && c for tree-sitter
if ! command -v cargo > /dev/null; then
  source "$dotfiles_dir/installers/rust.sh"
fi

if ! command -v gcc > /dev/null; then
  "$dotfiles_dir/installers/cplus.sh"
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

if ! command -v nvim > /dev/null; then
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install neovim
    sudo -u "$user" brew install tree-sitter
  elif command -v apt > /dev/null; then
    # Official ubuntu repo version waaaay too old
    # for some of my plugins.
    # Can switch to stable once better treesitter/lsp
    # support lands.
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update && sudo apt install vim neovim -y
  else
    echo "Unrecognized platform, aborting vim install"
    exit 1
  fi
fi

cargo install tree-sitter-cli

ensure-stow

# If it's an actual file we don't want to lose it
if [[ ! -L "~/.config/nvim/init.vim" && -f "~/.config/nvim/init.vim" ]]; then
  cp ~/.config/nvim/init.vim ~/.old_configs/init.vim
fi
rm -f ~/.config/nvim/init.vim

pushd $dotfiles_dir
stow -D nvim
stow nvim
popd

echo "done. Installing vim-plug..."
# install vim-plug for neovim and update neovim to use it
if ! [ -f "~/.local/share/nvim/site/autoload/plug.vim" ]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Requirement satisfied. Skipping..."
fi

# Install python3 client for neovim
sudo -u "$user" python3 -m pip install --user pynvim
