#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform")
arch=$(arch)
url="https://github.com/JCWasmx86/mesonlsp/releases/download/v4.1.8"
pkg=""

if ! command -v mesonlsp >/dev/null; then
  pushd /tmp
  if [ "$os" == "macos" ]; then
    if [ "$arch" == "arm64" ]; then
      pkg="mesonlsp-aarch64-apple-darwin"
    elif [ "$arch" == "i386" ] || [ "$arch" == "x86_64" ]; then
      pkg="mesonlsp-x86_64-apple-darwin.zip"
    else
      echo "Unknown architecture $arch. Aborting!" >&2
      exit 1
    fi
  elif [[ "$os" =~ "ubuntu" ]]; then
    pkg="mesonlsp-x86_64-pc-windows-gnu.zip"
  else
    echo "Unknown platform. Aborting!" >&2
    popd
    exit 1
  fi

  curl -OJ "$url/$pkg"
  unzip "$pkg"
  cp "$pkg/mesonlsp" /usr/local/bin/
  popd
fi
