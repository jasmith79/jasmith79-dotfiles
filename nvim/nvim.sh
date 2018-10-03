#!/bin/bash
# jasmith79's install script for neovim. 
# Assumes python3/pip3 already installed. For old ubuntu and 
# friends assumes the ppa has already been added.

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  NVIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$NVIMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
NVIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

mkdir -p ~/.vim/pack/jsmith/start
mkdir -p ~/.old_configs
mkdir -p ~/.config/nvim

if ! command -v nvim > /dev/null; then
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install neovim
  elif command -v apt > /dev/null; then
    sudo apt install vim neovim -y
  else
    echo "Unrecognized platform, aborting vim install"
    exit 1
  fi
fi

# If it's an actual file we don't want to lose it
if [ -f "~/.config/nvim/init.vim" ]; then
  cp ~/.config/nvim/init.vim ~/.old_configs/init.vim
fi
rm -f ~/.config/nvim/init.vim

ln -s $NVIMDIR/init.vim ~/.config/nvim/init.vim

echo "done. Installing vim-plug..."
# install vim-plug for neovim and update neovim to use it
if ! [ -f "~/.local/share/nvim/site/autoload/plug.vim" ]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Requirement satisfied. Skipping..."
fi

# Install python3 support for neovim
sudo -u "$user" python3 -m pip install --user neovim
