#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  FISHDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$FISHDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
FISHDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

mkdir -p ~/.old_configs
mkdir -p ~/.config/fish/functions

if ! command -v fish > /dev/null; then
  if command -v apt > /dev/null; then
    sudo apt install fish -y
  elif command -v brew > /dev/null; then
    brew install fish
  else
    echo "Unable to install fish!"
  fi
fi

if [ -f ~/.config/fish/config.fish ]; then
  cp ~/.config/fish/config.fish ~/.old_configs
fi

if [ -f ~/.config/fish/functions/fish_user_key_bindings.fish ]; then
  cp ~/.config/fish/functions/fish_user_key_bindings.fish ~/.old_configs
fi

rm -f ~/.config/fish/config.fish ~/.config/fish/functions/fish_user_key_bindings.fish
ln -s $FISHDIR/config.fish ~/.config/fish/config.fish
ln -s $FISHDIR/fish_user_key_bindings.fish ~/.config/fish/functions/fish_user_key_bindings.fish
