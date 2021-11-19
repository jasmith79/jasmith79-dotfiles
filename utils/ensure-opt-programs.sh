#!/bin/bash

DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"

user="$(bash "$DOTFILES_DIR/utils/better-whoami")"

ensure-opt-programs () {
  mkdir -p /opt/programs
  chown -R "$user" /opt/programs
}
