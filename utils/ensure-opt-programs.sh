#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

user="$(bash "$dotfiles_dir/utils/better-whoami")"

ensure-opt-programs () {
  sudo mkdir -p /opt/programs
  sudo chown -R "$user" /opt/programs
}
