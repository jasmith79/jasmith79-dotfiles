#!/bin/bash
# Ensures that git is installed and global configs set.
# Obvs, if you're not me change this to your creds.

DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$DOTFILES_DIR/utils/install-pkg.sh"

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
