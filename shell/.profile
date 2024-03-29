#!/bin/sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

os=$(uname)

# If running bash on macos and there's a .bashrc, source it.
# Need the OS check because this errors on ubuntu et al.
if [[ "$os" =~ [Dd]arwin && -n "$BASH_VERSION" && -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Add local rust install to PATH
if [ -d $HOME/.cargo ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Add android studio to path on linux
if [ -d /opt/programs/android-studio ]; then
  export PATH="$PATH:/opt/programs/android-studio/bin"
fi

# Use the gnu version of cli utils on Mac if installed
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# TODO: make it version agnostic rather than hardcoding 9.1
elif [ -d /opt/homebrew/Cellar/coreutils/9.1/libexec/gnubin ]; then
  export PATH="/opt/homebrew/Cellar/coreutils/9.1/libexec/gnubin:$PATH"
fi

if [ -d /usr/local/bin ]; then
  export PATH="/usr/local/bin:$PATH"
fi

# Add golang to the path if installed
if [ -d /usr/local/go ]; then
  export PATH="$PATH:/usr/local/go/bin"
fi

# Needed for cli-visualizer, all my terminal emulators should support
# at least 256 if not 24bit.
if [[ "$TERM" = "xterm" ]]; then
  export TERM=xterm-256color
fi

# PYTHON
if [ -d /Users/$USER/Library/Python ]; then
  # Yes, yes, I know, don't parse ls
  PYVERS=$(ls /Users/$USER/Library/Python | grep "^3" | tail -n 1)
fi

if ! [ -z "$PYVERS" ]; then
  export PATH="/Users/$USER/Library/Python/$PYVERS/bin:$PATH"
fi

if command -v nvim > /dev/null; then
  export EDITOR="nvim"
  export MANPAGER="nvim -c 'set ft=man' -"
elif command -v vim > /dev/null
then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# silence the stupid zsh warning in MacOS Catalina
export BASH_SILENCE_DEPRECATION_WARNING=1
