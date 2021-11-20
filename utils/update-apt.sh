#!/usr/bin/env bash
# Modified from https://askubuntu.com/a/904259/868447
# Updates the apt-cache if it hasn't been updated in the last 9 min.
# Used here to ensure that apt-update gets run at least once
# during the execution of all of these installs.
update-apt () {
  [ -z "$(find -H /var/lib/apt/lists -maxdepth 0 -mmin -9)" ] && sudo apt-get update
}
