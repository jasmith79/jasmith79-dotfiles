#!/usr/bin/fish
set dotfiles_dir "$(dirname $(dirname $(dirname $(dirname (readlink -m (status --current-filename))))))"

# import aliases
. ~/.aliases

# Always use neovim
if command -v nvim > /dev/null
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

# If using terminology, create an appropriate alias and set transparency to 80
# term_emu="/"(ps -f -p (cat /proc/(echo %self)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'
# if $term_emu =~ "terminology"
#   # The fullscreen option doesn't work in Cinnamon. 150 col x 55 lines is a
#   # reasonably large starting geometry, can max with mouse or keyboard after
#   # opening.
#   alias bigt='terminology -g 150x75 -S v-h'
#   tyalpha 80
#   function newt
#     terminology $argv > /dev/null ^&1
#   end
# end

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
  if count $argv > /dev/null
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
  if count $argv > /dev/null
    set n $argv
  else
    set n 15
  end
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c $n; echo
end

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "/opt/homebrew/bin"
fish_add_path "/opt/programs/android-studio/bin"
fish_add_path "/usr/local/opt/coreutils/libexec/gnubin"
fish_add_path "/opt/homebrew/Cellar/coreutils/9.1/libexec/gnubin"
fish_add_path "/usr/local/bin"
fish_add_path "/usr/local/go/bin"

function nv
  if count $argv > /dev/null
    set path $argv
  else
    set path .
  end

  nvim "$path"
end  

if command -v node >/dev/null
    eval "$(fnm env)"
	set CURRENT_NODE_VERS "$(node --version)"
	set MEETS_REQ "$(bash $dotfiles_dir/utils/check-version "v16.14.0" "$CURRENT_NODE_VERS")"
	if [ "$MEETS_REQ" != "passed" ]
        and [ -x "$(command -v fnm)" ]
		fnm use --install-if-missing 16.14
	end
end

