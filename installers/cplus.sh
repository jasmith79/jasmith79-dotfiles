#!/usr/bin/env bash
# Installs packages needed for c/c++ development.

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform") || exit 1
source "$dotfiles_dir/utils/install-pkg.sh"

if ! command -v make > /dev/null; then
  install-pkg make
fi

if ! command -v cmake > /dev/null; then
  install-pkg cmake
fi

if ! command -v autoconf > /dev/null; then
  install-pkg autoconf
fi

if ! command -v gcc > /dev/null; then
  install-pkg gcc
fi

if ! command -v g++ > /dev/null; then
  install-pkg g++
fi

if ! command -v meson > /dev/null; then
  install-pkg meson
fi

if [[ "$os" =~ "ubuntu" ]] && ! command -v valgrind > /dev/null; then
  install-pkg valgrind
fi

if [[ "$os" =~ "ubuntu" ]]; then
  # Only need to install clang on linux, xcode grabs it on mac
  if ! command -v clang > /dev/null; then
    install-pkg build-essential
    install-pkg llvm
    install-pkg clang-12 --install-suggests
  fi

  # package name a lil different
  if ! command -v ninja > /dev/null; then
    install-pkg ninja-build
  fi
fi

if [ "$os" = "macos" ]; then
  if ! command -v ninja > /dev/null; then
    install-pkg ninja
  fi
fi
