#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

mkdir -p ~/.old_configs

source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/ensure-stow.sh"
source "$dotfiles_dir/utils/pushpop.sh"

ensure-stow


if [[ ! -L ~/.local/bin && -d ~/.local/bin ]]; then
  cp -r ~/.local/bin ~/.old_configs
fi

rm -f ~/.local/bin/*

pushd "$dotfiles_dir"
stow -D bin
stow bin
popd

