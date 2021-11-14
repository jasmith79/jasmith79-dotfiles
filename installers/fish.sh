#!/bin/bash
DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

mkdir -p ~/.old_configs

source "$DOTFILES_DIR/utils/install-pkg.sh"
source "$DOTFILES_DIR/utils/ensure-stow.sh"

if ! command -v fish > /dev/null; then
  install-pkg "fish"
fi

# Install omf plugin manager
if command -v fish > /dev/null; then
  curl -L https://get.oh-my.fish | fish
fi

ensure-stow

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
