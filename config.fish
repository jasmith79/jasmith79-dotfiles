
# Always use neovim
alias vim='nvim'

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
if command -v tyalpha >/dev/null then
  # The fullscreen option doesn't work in Cinnamon. 150 col x 55 lines is a
  # reasonably large starting geometry, can max with mouse or keyboard after
  # opening.
  alias bigt='terminology -g 150x75 -S v-h'
  tyalpha 80
  function newt
    terminology $argv > /dev/null ^&1
  end
end

if command -v cmus >/dev/null then
  alias shuffle='cmus-remote -S'
  alias pause='cmus-remote -u'
  alias play='cmus-remote -p'
  alias next='cmus-remote -n'
  alias prev='cmus-remote -r'
end

if command -v rofi >/dev/null then
  alias run='rofi -show run > /dev/null ^&1'
  alias swit='rofi -show window > /dev/null ^&1'
end

if command -v vtop >/dev/null then
  alias vtop='vtop --theme dark'
end

function randompass
  set LC_ALL C
  if count $argv > /dev/null
    set n $argv
  else
    set n 15
  end
  tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c $n; echo
end

alias resetsound='pulseaudio -k; and sudo alsa force-reload'

set fish_greeting 'It\'s dangerous to go alone. Take this with you.'

neofetch
