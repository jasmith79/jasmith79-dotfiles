#!/bin/bash
# Jared Smith's bashrc.
# Note that on OSX all shells by default are run as login shells.
# Be sure to add a conditional check in .profile o ensure that
# this file gets sourced.

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
os=$(uname)

dotfiles_dir="$(dirname "$(readlink -f "$0")")"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -d /opt/homebrew/bin ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -x /usr/bin/mint-fortune ]; then
  /usr/bin/mint-fortune
fi

# Set vi keybinding for default shell
set -o vi

if [ "$TILIX_ID" ] || [ "$VTE_VERSION" ]; then
  source /etc/profile.d/vte-2.91.sh
fi

#### ALIASES ####
if command -v nvim >/dev/null; then
  alias vim='nvim'
fi

# If using terminology, create an appropriate alias and set transparency to 80
# NOTE: the basename check isn't portable, won't work on FreeBSD or OSX
# if [[ "$os" = "Linux" ]]; then
#   basename="/"$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //')
#   if [[ "$basename" =~ "terminology" ]]; then
#     newt () {
#       terminology "$@" &>/dev/null &
#     }
#     alias newt='newt'
#     # The fullscreen option doesn't work in Cinnamon. 150 col x 55 lines is a
#     # reasonably large starting geometry, can max with mouse or keyboard after
#     # opening.
#     alias bigt='terminology -g 150x75 -S v-h'
#     tyalpha 80
#   fi
# fi

# Generates a cryptographically secure random password of
# length n (default is 15 characters)
randompass () {
  n=${1-15}
  export LC_ALL=C
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c "$n"; echo
}

# Kills the docker image that matches the argument
dkill () {
  docker ps | grep "$1" | grep -oE "^[a-f0-9]+" | xargs docker rm -f
}

vimd () {
  vim -c 'colorscheme dracula' -c 'set background=dark' "$@"
}

alias vimd='vimd'

# Set fish as my shell if available unless on OSX
if ! [[ "$os" = "Darwin" ]]; then
  FISH_PATH=$(command -v fish)
  if [ -n "$FISH_PATH" ] && ! [[ "$SHELL" =~ "fish" ]]; then
    IS_VALID_SHELL=$(grep "fish" /etc/shells)
    if [ -z "$IS_VALID_SHELL" ]; then
      echo "$FISH_PATH" | sudo tee -a /etc/shells
    fi
    chsh -s "$FISH_PATH"
    echo "Shell has been changed to fish. In order prevent this command from running multiple times, please log out and
    back in or restart the machine."
  fi
fi

# Add local rust install to PATH
if [ -d "$HOME/.cargo" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Add haskell toolchain if present
if [ -f "$HOME/.ghcup/env" ]; then
	source "$HOME/.ghcup/env"
fi

# Add TS language server et. al.


# added by travis gem
[ ! -s /Users/jsmith/.travis/travis.sh ] || source /Users/jsmith/.travis/travis.sh

rusty () {
  RUST_BACKTRACE=1 && cargo run "$@"
}

# Currently handled in fish config.
# if command -v node >/dev/null; then
#     eval "$(fnm env)"
# 	CURRENT_NODE_VERS="$(node --version)"
# 	MEETS_REQ="$(bash $dotfiles_dir/utils/check-version "v16.14.0" "$CURRENT_NODE_VERS")"
# 	if [ "$MEETS_REQ" != "passed" ] && [ -x "$(command -v fnm)" ]; then
# 		fnm use --install-if-missing 16.14
# 	fi
# fi

