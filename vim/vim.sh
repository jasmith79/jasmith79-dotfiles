#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  VIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$VIMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
VIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

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
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/schemes
mkdir -p ~/.old_configs

if ! command -v vim > /dev/null; then
  if command -v apt > /dev/null; then
    sudo apt install vim -y
  else
    echo "Unrecognized platform, cannot install vim"
  fi
fi

if [ -d ~/.vim/pack/jsmith/start/tcomment_vim ]; then
  cd ~/.vim/pack/jsmith/start/tcomment_vim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tomtom/tcomment_vim.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-airline ]; then
  cd ~/.vim/pack/jsmith/start/vim-airline
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/vim-airline/vim-airline.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-airline-themes ]; then
  cd ~/.vim/pack/jsmith/start/vim-airline-themes
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/vim-airline/vim-airline-themes.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-eunuch ]; then
  cd ~/.vim/pack/jsmith/start/vim-eunuch
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-eunuch.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-fireplace ]; then
  cd ~/.vim/pack/jsmith/start/vim-fireplace
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-fireplace.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-fugitive ]; then
  cd ~/.vim/pack/jsmith/start/vim-fugitive
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-fugitive.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-repeat ]; then
  cd ~/.vim/pack/jsmith/start/vim-repeat
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-repeat.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-surround ]; then
  cd ~/.vim/pack/jsmith/start/vim-surround
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-surround.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-gitgutter ]; then
  cd ~/.vim/pack/jsmith/start/vim-gitgutter
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/airblade/vim-gitgutter.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-multiple-cursors ]; then
  cd ~/.vim/pack/jsmith/start/vim-multiple-cursors
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/terryma/vim-multiple-cursors.git
fi

if [ -d ~/.vim/pack/jsmith/start/denite.nvim ]; then
  cd ~/.vim/pack/jsmith/start/denite.nvim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/Shougo/denite.nvim.git
fi

if [ -d ~/.vim/pack/jsmith/start/deoplete.nvim ]; then
  cd ~/.vim/pack/jsmith/start/deoplete.nvim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/Shougo/deoplete.nvim.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-polyglot ]; then
  cd ~/.vim/pack/jsmith/start/vim-polyglot
  git pull
else
  git clone https://github.com/sheerun/vim-polyglot.git ~/.vim/pack/jsmith/start/vim-polyglot
fi

if [ -d ~/.vim/pack/jsmith/start/vim-parinfer ]; then
  cd ~/.vim/pack/jsmith/start/vim-parinfer
  git pull
else
  git clone https://github.com/bhurlow/vim-parinfer.git ~/.vim/pack/jsmith/start/vim-parinfer
fi

if [ -d ~/.vim/pack/jsmith/start/auto-pairs ]; then
  cd ~/.vim/pack/jsmith/start/auto-pairs
  git pull
else
  git clone https://github.com/jiangmiao/auto-pairs
fi

if [ -d ~/.vim/schemes/vim-colors-solarized ]; then
  cd ~/.vim/schemes/vim-colors-solarized
  git pull
else
  cd ~/.vim/schemes
  git clone https://github.com/altercation/vim-colors-solarized.git
  ln -s ~/.vim/schemes/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/solarized.vim
fi

if [ -d ~/.vim/schemes/vim-solarized8 ]; then
  cd ~/.vim/schemes/vim-solarized8
  git pull
else
  cd ~/.vim/schemes
  git clone https://github.com/lifepillar/vim-solarized8.git
  ln -s ~/.vim/schemes/vim-solarized8/colors/solarized8.vim ~/.vim/colors/solarized8.vim
  ln -s ~/.vim/schemes/vim-solarized8/colors/solarized8_flat.vim ~/.vim/colors/solarized8_flat.vim
  ln -s ~/.vim/schemes/vim-solarized8/colors/solarized8_dark_flat.vim ~/.vim/colors/solarized8_dark_flat.vim
fi

if [ -d ~/.vim/schemes/flattened ]; then
  cd ~/.vim/schemes/flattened
  git pull
else
  git clone https://github.com/romainl/flattened.git
  ln -s ~/.vim/schemes/flattened/colors/flattened_dark.vim ~/.vim/colors/flattened_dark.vim
fi

if [ -d ~/.vim/pack/jsmith/start/dracula ]; then
  cd ~/.vim/pack/jsmith/start/dracula
  git pull
else
  git clone https://github.com/dracula/vim ~/.vim/pack/jsmith/start/dracula
fi

if [ -d ~/.vim/schemes/vim-atom-dark ]; then
  cd ~/.vim/schemes/vim-atom-dark
  git pull
else
  git clone https://github.com/gosukiwi/vim-atom-dark.git
  ln -s ~/.vim/schemes/vim-atom-dark/colors/atom-dark-256.vim ~/.vim/colors/atom-dark-256.vim
fi

# If it's an actual file, save it
if [ -f "~/.vimrc" ]; then
  cp ~/.vimrc ~/.old_configs/.vimrc
fi
rm -f ~/.vimrc

ln -s $VIMDIR/vimrc ~/.vimrc

