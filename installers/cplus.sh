#!/usr/bin/env bash
# Installs packages needed for c/c++ development.

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform") || exit 1
source "$dotfiles_dir/utils/install-pkg.sh"

install-pkg make
install-pkg cmake
install-pkg autoconf
install-pkg gcc
install-pkg g++
install-pkg meson
install-pkg valgrind

if [ "$os" =~ "ubuntu" ]; then
  # Only need to install clang on linux, xcode grabs it
  install-pkg build-essential
  install-pkg llvm
  install-pkg clang-12 --install-suggests

  # package name a lil different
  install-pkg ninja-build
fi

if [ "$os" = "Darwin" ]; then
  install-pkg ninja
fi
