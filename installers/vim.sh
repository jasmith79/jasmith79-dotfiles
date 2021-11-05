#!/bin/bash
# jasmith79's install script for vim.

# This script is located inside a file named installers
# inside my dotfiles dir which should be inside $HOME
# for stow to work properly.
#
# This will grab the path to the dotfiles dir, quoting to
# guard against spaces in paths, e.g. I set my user name to
# "Jared Smith" or something.
DOTFILES_DIR = "$(dirname "$(dirname "$(readlink -f "$0")")"

# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

mkdir -p ~/.vim/colors

if ! command -v vim > /dev/null; then
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install vim
  elif command -v apt > /dev/null; then
    sudo apt-get update && sudo apt install vim
  else
    echo "Unrecognized platform, aborting vim install"
    exit 1
  fi
fi

# Double-check we have stow.
if ! command -v stow > /dev/null; then
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install stow
  elif command -v apt > /dev/null; then
    sudo apt-get update && sudo apt install stow -y
  else
    echo "Unrecognized platform, aborting vim install"
    exit 1
  fi
fi

# If it's an actual file, save it
if [[ ! -L "~/.vimrc" &&-f "~/.vimrc" ]]; then
  cp ~/.vimrc ~/.old_configs/.vimrc
fi
rm -f ~/.vimrc

pushd $DOTFILES_DIR
stow config
popd

echo "Done."
