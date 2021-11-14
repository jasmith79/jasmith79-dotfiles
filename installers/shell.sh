#!/bin/bash
# NOTE: assumes bash already installed.
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

source "$DOTFILES_DIR/utils/ensure-stow.sh"

mkdir -p ~/.old_configs

ensure-stow

if [[ ! -L ~/.bashrc && -f ~/.bashrc ]]; then
  mv ~/.bashrc ~/.old_configs
fi

if [[ ! -L ~/.bash_profile && -f ~/.bash_profile ]]; then
  mv ~/.bash_profile ~/.old_configs
fi

if [[ ! -L ~/.aliases && -f ~/.aliases ]]; then
  mv ~/.aliases ~/.old_configs
fi

if [[ ! -L ~/.profile && -f ~/.profile ]]; then
  mv ~/.profile ~/.old_configs
fi

rm -f ~/.aliases
rm -f ~/.bashrc
rm -f ~/.bash_profile
rm -f ~/.profile

pushd $DOTFILES_DIR
stow -D shell
stow shell
popd
