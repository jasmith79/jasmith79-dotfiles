os=$(uname)

# Determine working directory
wd=$(pwd)

# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
  user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
  user="$who"
fi

# TODO: replace these with version checks
if command -v git >/dev/null; then
  echo "Git successfully installed."
else
  echo "ERROR: missing git."
fi

if command -v gcc >/dev/null; then
  echo "gcc successfully installed."
else
  echo "ERROR: missing gcc."
fi

if command -v make >/dev/null; then
  echo "Make successfully installed."
else
  echo "ERROR: missing make."
fi

if command -v node >/dev/null; then
  echo "Nodejs successfully installed."
else
  echo "ERROR: missing nodejs."
fi

if command -v webpack >/dev/null; then
  echo "Webpack successfully installed."
else
  echo "ERROR: missing webpack."
fi

if command -v yarn >/dev/null; then
  echo "Yarn successfully installed."
else
  echo "ERROR: missing yarn."
fi

if command -v atom >/dev/null; then
  echo "Atom successfully installed."
else
  echo "ERROR: missing atom."
fi

if command -v vagrant >/dev/null; then
  echo "vagrant successfully installed."
else
  echo "ERROR: missing vagrant."
fi

if command -v ansible-playbook >/dev/null; then
  echo "Ansible successfully installed."
else
  echo "ERROR: missing ansible."
fi

if command -v virtualenv >/dev/null; then
  echo "virtualenv successfully installed."
else
  echo "ERROR: missing virtualenv."
fi

if command -v python3 >/dev/null; then
  echo "Python3 successfully installed."
else
  echo "ERROR: missing python3."
fi

if command -v pip3 >/dev/null; then
  echo "pip3 successfully installed."
else
  echo "ERROR: missing pip3."
fi

if command -v fish >/dev/null; then
  echo "Fish shell successfully installed."
else
  echo "ERROR: missing fish shell."
fi

if command -v clj >/dev/null; then
  echo "Clojure successfully installed."
else
  echo "ERROR: missing Clojure."
fi

if command -v lein >/dev/null; then
  echo "Leiningen successfully installed."
else
  echo "ERROR: missing leiningen."
fi

if command -v nvim >/dev/null; then
  echo "Neovim successfully installed."
else
  echo "ERROR: missing neovim."
fi

if command -v greadlink > /dev/null; then
  bashlnk="$(greadlink -f ~/.bashrc)"
  vimlnk="$(greadlink -f ~/.vimrc)"
  nvimlnk="$(greadlink -f ~/.config/nvim/init.vim)"
  fishlnk="$(greadlink -f ~/.config/fish/config.fish)"
  keylnk="$(greadlink -f ~/.config/fish/functions/fish_user_key_bindings.fish)"
else
  bashlnk="$(readlink -f ~/.bashrc)"
  vimlnk="$(readlink -f ~/.vimrc)"
  nvimlnk="$(readlink -f ~/.config/nvim/init.vim)"
  fishlnk="$(readlink -f ~/.config/fish/config.fish)"
  keylnk="$(readlink -f ~/.config/fish/functions/fish_user_key_bindings.fish)"
fi

if [[ "$bashlnk" = "$wd/bashrc" ]]; then
  echo "~/.bashrc successfully copied"
else
  echo "ERROR: missing bashrc"
fi

if [[ "$vimlnk" = "$wd/vim/vimrc" ]]; then
  echo "~/.vimrc successfully copied"
else
  echo "ERROR: missing vimrc"
fi

if [[ "$fishlnk" = "$wd/fish/config.fish" ]]; then 
  echo "~/.config/fish/config.fish successfully copied"
else
  echo "ERROR: missing config.fish"
fi

if [[ "$keylnk" = "$wd/fish/fish_user_key_bindings.fish" ]]; then 
  echo "fish key bindings successfully installed"
else
  echo "ERROR: missing fish key bindings"
fi

if [[ "$nvimlnk" = "$wd/nvim/init.vim" ]]; then
  echo "~/.config/nvim/init.vim successfully copied"
else
  echo "ERROR: missing init.vim"
fi

if [[ $os = "Darwin" ]]; then
  echo "OS X runs all shells as login, be sure to add an appropriate source command to .bash_profile"
  echo "See my .bashrc for details."
else
  if command -v greadlink > /dev/null; then
    termlnk="$(greadlink -f ~/.config/terminology/config/standard/base.cfg)"
  else
    termlnk="$(readlink -f ~/.config/terminology/config/standard/base.cfg)"
  fi

  if command -v terminology >/dev/null; then
    echo "Terminology successfully installed."
  else
    echo "ERROR: missing terminology."
  fi

  if [[ "$termlnk" = "$wd/terminology/terminology.cfg" ]]; then 
    echo "~/.config/terminology/config/standard/base.cfg successfully copied"
  else
    echo "ERROR: missing terminology base.cfg"
  fi
fi
