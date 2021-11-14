# OSX won't load this on login, cuz not real *nix
if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [ -d "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
