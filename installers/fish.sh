#!/bin/bash
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

mkdir -p ~/.old_configs

if ! command -v fish > /dev/null; then
  if command -v apt > /dev/null; then
    sudo apt install fish -y
  elif command -v brew > /dev/null; then
    brew install fish
  else
    echo "Unable to install fish!"
    exit 1
  fi
fi

# Install omf plugin manager
if command -v fish > /dev/null; then
  curl -L https://get.oh-my.fish | fish
fi

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

if [[ ! -L ~/.config/fish/config.fish && -f ~/.config/fish/config.fish ]]; then
  cp ~/.config/fish/config.fish ~/.old_configs
fi

if [[ ! -L ~/.config/fish/functions/fish_user_key_bindings.fish && -f ~/.config/fish/functions/fish_user_key_bindings.fish ]]; then
  cp ~/.config/fish/functions/fish_user_key_bindings.fish ~/.old_configs
fi

rm -f ~/.config/fish/config.fish ~/.config/fish/functions/fish_user_key_bindings.fish

pushd $DOTFILES_DIR
stow -D fish
stow fish
popd
