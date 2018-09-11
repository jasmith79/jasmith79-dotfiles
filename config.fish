
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
if command -v tyalpha >/dev/null 2>&1
  alias bigt='terminology -S v-h'
  tyalpha 80
end
