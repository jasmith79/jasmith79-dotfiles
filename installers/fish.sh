#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

mkdir -p ~/.old_configs

source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"

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

pushd "$dotfiles_dir" || exit 1
stow -D fish
stow fish
popd || exit 1
