#!/usr/bin/env bash
# jasmith79's install script for vim.

# This script is located inside a file named installers
# inside my dotfiles dir which should be inside $HOME
# for stow to work properly.
#
# This will grab the path to the dotfiles dir, quoting to
# guard against spaces in paths, e.g. I set my user name to
# "Jared Smith" or something.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"
source "$dotfiles_dir/utils/update-apt.sh"

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
    update-apt
    sudo apt install vim vim-doc vim-scripts ctags -y 
  else
    echo "Unrecognized platform, aborting vim install"
    exit 1
  fi
fi

ensure-stow

# If it's an actual file, save it
if [[ ! -L "~/.vimrc" && -f "~/.vimrc" ]]; then
  cp ~/.vimrc ~/.old_configs/.vimrc
fi
rm -f ~/.vimrc

pushd $dotfiles_dir
stow -D vim
stow vim
popd

echo "Done."
