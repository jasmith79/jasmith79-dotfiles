#!/usr/bin/env bash
# Installs the MacOS-specific parts of my setup

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

if [ "$(uname)" != "Darwin" ]; then
  echo "Trying to install MacOS components on another platform, aborting!" >&2
  exit 1
fi

source "$dotfiles_dir/utils/ensure-brew.sh"
source "$dotfiles_dir/utils/ensure-opt-programs.sh"

# Xcode CLI tools, e.g. git, clang
if ! command -v clang > /dev/null; then
  xcode-select --install
fi

# Homebrew
ensure-brew

# Current bash is 5.x but because of GPL licensing
# issues Apple has MacOS bash pegged at *3.x* which
# is now almost 15 years old. Installs if current
# bash version < 5.0.0
bash_version=$(bash --version | grep -oE '\d+\.\d+\.\d+')
if [ "$bash_version" != "$(echo "$bash_version" "5.0.0" | sort -V | cut -f1 -d ' ')" ]; then
  brew install bash
fi

# I like having a consistent experience across OSes, and the GNU
# utilities are usually better anyway.
gnu_path="/usr/local/opt/coreutils/libexec/gnubin"
case :$PATH:
  in *:$gnu_path:*) ;;
     *)
      brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
      export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
      export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
      ;;
esac

if ! [ -f /Applications/iTerm.app ] && ! [ -f "$HOME/Applications/iTerm.app" ]; then
  brew install --cask iterm2
  curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
fi

if ! command -v imgcat > /dev/null; then
  ensure-opt-programs
  curl https://www.iterm2.com/utilities/imgcat > /opt/programs/imgcat
  chmod +x /opt/programs/imgcat
  sudo mv /opt/programs/imgcat /usr/local/bin
fi
