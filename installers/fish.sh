#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform")

mkdir -p ~/.old_configs

source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"

if ! command -v fish > /dev/null; then
  install-pkg "fish"
  pushd /tmp
  curl -L https://get.oh-my.fish > omfish

  # Not sure if this creates a race condition
  # for writing the omf conf...
  fish omfish &>/dev/null &
  popd
fi

ensure-stow

if [[ ! -L ~/.config/fish/config.fish && -f ~/.config/fish/config.fish ]]; then
  cp ~/.config/fish/config.fish ~/.old_configs
fi

if [[ ! -L ~/.config/fish/functions/fish_user_key_bindings.fish && -n ~/.config/fish/functions/fish_user_key_bindings.fish ]]; then
  cp ~/.config/fish/functions/fish_user_key_bindings.fish ~/.old_configs
fi

rm -f ~/.config/fish/config.fish ~/.config/fish/functions/fish_user_key_bindings.fish

pushd "$dotfiles_dir"
stow -D fish
stow fish
popd

