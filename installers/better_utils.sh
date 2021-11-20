#!/usr/bin/env bash
# Installs better shell utils:
#
# exa     replacement for ls
# bat     replacement for cat
# ripgrep replacement for grep
# fd      replacement for find
# tokei   counts LoC in various languages
# procs   replacement for ps
# sd      replacement for sed
# dust    replacement for du
# broot   replacement for tree
# nomino  batch rename
#
# Note that for easiest portability as well as to get
# the most latest recentest juiciest versions I use cargo,
# THIS MEANS THAT EVERYTHING IS COMPILED, WHICH TAKES
# FOREVER AND WILL MAKE YOUR FAN GO BRRRR. If you want
# a faster experience with less space-heating, comment out
# all the cargo installs and uncomment the install-pkg
# installs. Note that I don't use them, haven't checked
# them, and they may well fail on some or even all
# platforms.
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

# Need rust and cargo for all these
if ! command -v rustup > /dev/null; then
  source "$dotfiles_dir/installers/rust.sh"
fi

# Specify actual path because it may not be on $PATH yet
# if it just got installed
if ! command -v exa > /dev/null; then
  ~/.cargo/bin/cargo install exa
fi

if ! command -v bat > /dev/null; then
  ~/.cargo/bin/cargo install --locked bat
fi

if ! command -v rg > /dev/null; then
  ~/.cargo/bin/cargo install ripgrep # bin name is rg
fi

if ! command -v fd-find > /dev/null; then
  ~/.cargo/bin/cargo install fd-find
fi

if ! command -v tokei > /dev/null; then
  ~/.cargo/bin/cargo install tokei
fi

if ! command -v procs > /dev/null; then
  ~/.cargo/bin/cargo install procs
fi

if ! command -v sd > /dev/null; then
  ~/.cargo/bin/cargo install sd
fi

if ! command -v dust > /dev/null; then
  ~/.cargo/bin/cargo install du-dust # bin name is dust
fi

if ! command -v br > /dev/null; then
  ~/.cargo/bin/cargo install broot # bin name is br
fi

if ! command -v nomino > /dev/null; then
  ~/.cargo/bin/cargo install nomino
fi

# Untested!
# if ! command -v exa > /dev/null; then
#   install-pkg "exa"
# fi

# if ! command -v bat > /dev/null; then
#   install-pkg "bat"
# fi

# if ! command -v rg > /dev/null; then
#   install-pkg "ripgrep" # bin name is rg
# fi

# if ! command -v fd-find > /dev/null; then
#   install-pkg "fd-find"
# fi

# if ! command -v tokei > /dev/null; then
#   install-pkg "tokei"
# fi

# if ! command -v procs > /dev/null; then
#   install-pkg "procs"
# fi

# if ! command -v sd > /dev/null; then
#   install-pkg "sd"
# fi

# if ! command -v dust > /dev/null; then
#   install-pkg "du-dust" # bin name is dust
# fi

# if ! command -v br > /dev/null; then
#   install-pkg "broot" # bin name is br
# fi

# if ! command -v nomino > /dev/null; then
#   install-pkg "nomino"
# fi
