#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

user="$(bash "$dotfiles_dir/utils/better-whoami")"

ensure-opt-programs () {
  mkdir -p /opt/programs
  chown -R "$user" /opt/programs
}
