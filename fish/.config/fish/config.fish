#!/usr/bin/fish
set dotfiles_dir "$(dirname $(dirname $(dirname $(dirname (readlink -m (status --current-filename))))))"

set MOST_RECENT_COREUTILS "$(bash $dotfiles_dir/utils/latest-coreutils)"

# import aliases
. ~/.aliases

# Always use neovim
if command -v nvim >/dev/null
    alias vim='nvim'
end

# vi bindings on the terminal
# NOTE: if using fish < 2.3 then you'll need to take the following steps to
# acheive this:
#
# mkdir ~/.config/fish/functions
# touch ~/.config/fish/functions/fish_user_key_bindings.fish
#
# then edit it to contain the following:
#
# function fish_user_key_bindings
#  fish_vi_key_bindings
# end
fish_vi_key_bindings

set SPACEFISH_USER_SHOW always
set SPACEFISH_USER_COLOR af5fff
set SPACEFISH_DIR_COLOR ffaf5f
set SPACEFISH_GIT_BRANCH_COLOR green
set SPACEFISH_PROMPT_SEPARATE_LINE false
set SPACEFISH_DIR_TRUNC_REPO false
set SPACEFISH_EXEC_TIME_SHOW false

set fish_greeting 'It\'s dangerous to go alone. Take this with you.'

# Generates a git tag and commit msg with the supplied version number.
function gtag
    git tag -a $argv -m "$argv"
end

function vimd
    vim -c 'set background=dark' $argv
end

# Scans a block of IP addresses for boxes that have ssh available.
# Useful for finding headless servers you didn't assign a static
# ip on your local network.
function sshscan
    if count $argv >/dev/null
        set ip $argv
    else
        set ip 192.168.1.0
    end
    sudo nmap -sS -p 22 $ip/24
end

# Kills the docker image that matches the argument
# function dkill
#   docker ps | grep $argv | egrep -o "^[a-f0-9]+" | xargs docker rm -f
# end

# Generates a cryptographically secure random password of
# length n (default is 15 characters)
function randompass
    set LC_ALL C
    if count $argv >/dev/null
        set n $argv
    else
        set n 15
    end
    tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c $n
    echo
end

# Update the PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/programs/android-studio/bin
fish_add_path /usr/local/bin
fish_add_path /usr/local/go/bin
fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"

# At some point MacOS brew util moved the location
# so we check for both, these next two use GNU utils
# over the POSIX ones so I have consistent behavior
# between Linux and MacOS
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path "/opt/homebrew/Cellar/coreutils/$MOST_RECENT_COREUTILS/libexec/gnubin"

# envars
if test "$TERM" = xterm
    set TERM xterm-256color
end

if type -q nvim
    set EDITOR nvim
    set MANPAGER "nvim -c 'set ft=man' -"
else if type -q vim
    set EDITOR vim
else
    set EDITOR vi
end

if test -d "/Users/$User/Library/Python"
    # Yes, yes, I know, don't parse ls
    set PYVERS "$(ls /Users/$USER/Library/Python | grep "^3" | tail -n 1)"
end

if set -q PYVERS
    fish_add_path "/Users/$USER/Library/Python/$PYVERS/bin"
end

if test -d "/opt/homebrew/opt/openssl@3"
    fish_add_path "/opt/homebrew/opt/openssl@3/bin"
    export LDFLAGS="-L /opt/homebrew/opt/openssl@3/lib"
    export CPPFLAGS="-I /opt/homebrew/opt/openssl@3/include"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"
end

# colored GCC warnings and errors
set GCC_COLORS "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

function nv
    if count $argv >/dev/null
        set path $argv
    else
        set path .
    end

    nvim "$path"
end

if command -v node >/dev/null
    eval "$(fnm env)"
    set CURRENT_NODE_VERS "$(node --version)"
    set MEETS_REQ "$(bash $dotfiles_dir/utils/check-version "v20.13.1" "$CURRENT_NODE_VERS")"
    if [ "$MEETS_REQ" != passed ]
        and [ -x "$(command -v fnm)" ]
        fnm use --install-if-missing 20 2>&1 >/dev/null
    end
end

# We want to start tmux but only if we're not in an integrated
# terminal and it isn't already running.
# if test -z "$VIM"; and test -z "$TMUX"
#   # If at work start/attach to main project, otherwise just run
#   # a new session.
#   if test -n "$KROGER"
#     kwc
#   else
#     tmux new-session
#   end
# end

if test -f "$HOME/.kroger"
    source "$HOME/.kroger"
end
