#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform") || exit 1

source "$dotfiles_dir/utils/install-pkg.sh"
source "$dotfiles_dir/utils/pushpop.sh"

# Need e.g. build-essential on Linux, easier to
# just grab all my C/C++ setup.
if ! command -v clang > /dev/null; then
  source "$dotfiles_dir/installers/cplus.sh"
fi

if ! command -v curl > /dev/null; then
  install-pkg "curl"
fi

if ! command -v rustup > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME"/.cargo/env
  rustup install stable
  rustup default stable
fi

if ! command -v rust-analyzer > /dev/null; then
  pushd /tmp
  if [[ "$os" =~ "mac" ]]; then
    RUST_ANALYZER_LINK="https://github.com/rust-lang/rust-analyzer/releases/download/2022-05-30/rust-analyzer-x86_64-apple-darwin.gz"
  else
    RUST_ANALYZER_LINK="https://github.com/rust-lang/rust-analyzer/releases/download/2022-06-06/rust-analyzer-x86_64-unknown-linux-gnu.gz"
  fi

  if [ -z "$RUST_ANALYZER_LINK" ]; then
    exit 1
  else
    curl -L "$RUST_ANALYZER_LINK" | gunzip -c - > ./rust-analyzer
    chmod +x rust-analyzer
    mv ./rust-analyzer /usr/local/bin/rust-analyzer
  fi
  popd
fi

