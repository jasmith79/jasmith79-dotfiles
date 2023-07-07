#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

mkdir -p ~/.old_configs

source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"

if [[ ! -L ~/.config/tmux/tmux.conf && -f ~/.config/tmux/tmux.conf ]]; then
  cp ~/.config/tmux/tmux.conf ~/.old_configs
fi

rm -f ~/.config/tmux/tmux.conf

ensure-stow

pushd "$dotfiles_dir"
stow -D tmux
stow tmux
popd

