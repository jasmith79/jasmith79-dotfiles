#!/bin/bash

DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
source "$DOTFILES_DIR/utils/install-pkg.sh"
