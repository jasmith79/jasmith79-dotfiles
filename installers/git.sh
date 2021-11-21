#!/usr/bin/env bash
# Ensures that git is installed and global configs set.
# Obvs, if you're not me change this to your creds.

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os="$(bash "$dotfiles_dir/utils/get-platform")"

source "$dotfiles_dir/utils/install-pkg.sh"

if ! command -v git > /dev/null; then
  install-pkg git
fi

git_user=$(git config user.name)
if [ -z "$git_user" ]; then
  git config --global user.name jsmith
fi

git_email=$(git config user.email)
if [ -z "$git_email" ]; then
  git config --global user.email jasmith79@gmail.com
fi

git config --global push.default simple

if [ "$os" = "macos" ]; then
  git config --global credential.helper osxkeychain
fi
