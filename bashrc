# Jared Smith's bashrc.
# Note that on OSX all shells by default are run as login shells. Be sure to add the following
# if [ -f ~/.bashrc ]; then
#   source ~/.bashrc
# fi
# To ensure that this file gets sourced.

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

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
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
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

# To re-enable emscripten sdk, uncomment the following line and comment out the one after. You should probably look at re-installing at that point.
#export PATH="$HOME/.local/bin:/opt/android-studio/bin:/usr/local/bin:$PATH"
export PATH=":/opt/android-studio/bin:/usr/local/bin:$PATH"

# pyenv
# Not sure why this is here?
# export PATH="/Users/jared/.pyenv:$PATH"
# eval "$(pyenv init -)"

# Set vi keybinding for default shell
set -o vi

# Add android studio to the PATH
export PATH="$HOME/.local/bin:/opt/android-studio/bin:$PATH"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte-2.91.sh
fi

#### ALIASES ####

if command -v nvim >/dev/null; then
  alias vim='nvim'
fi

# If using terminology, create an appropriate alias and set transparency to 80
if command -v tyalpha >/dev/null; then
  function newt () {
    terminology "$@" &>/dev/null &
  }
  alias newt='newt'
  # The fullscreen option doesn't work in Cinnamon. 150 col x 55 lines is a
  # reasonably large starting geometry, can max with mouse or keyboard after
  # opening.
  alias bigt='terminology -g 150x75 -S v-h'
  tyalpha 80
fi

if command -v cmus >/dev/null; then
  alias shuffle='cmus-remote -S'
  alias pause='cmus-remote -u'
  alias play='cmus-remote -p'
  alias next='cmus-remote -n'
  alias prev='cmus-remote -r'
fi

if command -v rofi >/dev/null; then
  alias run='rofi -show run &> /dev/null &'
  alias swit='rofi -show window &> /dev/null &'
fi

if command -v vtop >/dev/null; then
  alias vtop='vtop --theme dark'
fi

function randompass () {
  n=${1-15}
  export LC_ALL=C
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $n; echo
}

alias randompass='randompass'

function vimd () {
  vim -c 'colorscheme flattened_dark' $@
}

alias vimd='vimd'

# Needed to periodically fix sound flubs in Vbox VMs.
alias resetsound='pulseaudio -k'

# Needed for cli-visualizer
export TERM=xterm-256color

# Do you have any fish shell? Go fish
if command -v fish >/dev/null; then
  fish
fi
