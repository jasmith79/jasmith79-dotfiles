#!/usr/bin/bash

if [[ $(uname) =~ [Dd]arwin ]]; then
  echo "On OS X"
  # NOTE: the rest of this assumes that you have the XCode CLI tools installed.

  # Install brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # From here on its similar-ish to linux, but yah know, OS X isn't super terminal-friendly
  echo "Installing prerequisites...as far as we can in OS X anyway..."
  brew install fish
  brew install neovim
  brew install git
  brew install nodejs  # current LTS generally
  brew install python3 # also usually current

  # Python stuff
  python3 -m pip --user install --upgrade pip
  python3 -m pip --user install setuptools

  # Node stuff
  npm install -g webpack
  npm install -g webpack-cli
  npm install -g webpack-dev-server
  echo "Done."

elif [[ $(uname) =~ [Ll]inux ]]
then
  # For now, we're assuming "Linux" means Ubuntu or Mint
  # TODO: rework for yum/pacman later.
  ubuntu_version=0
  distro=$(cat /etc/lsb-release | head -n 1 | grep -o "=[a-zA-Z]\+" | cut -c2-)
  if [ $distro == "LinuxMint" ]; then
    ubuntu_version=$(cat /etc/upstream-release/lsb-release | grep -o "[0-9]\{2\}\.[0-9]\{2\}")
  elif [ $distro == "Ubuntu" ]
  then
    ubuntu_version=$(cat /etc/lsb-release | grep -o "[0-9]\{2\}\.[0-9]\{2\}")
  else
    echo "Unknown Linux Distro:"
    echo "$distro"
    echo "Aborting..."
    exit 1
  fi

  if [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version && $(echo "$ubuntu_version > 17.04" | bc) ]]; then
    echo "Older Ubuntu base detected. Adding ppas..."
    sudo add-apt-repository ppa:enlightenment-git/ppa -y
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    echo "Done."
  fi
  
  echo "Updating system repository database..."
  sudo apt-get update
  echo "Done."

  echo "Installing prerequisites..."
  if [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version && $(echo "$ubuntu_version > 17.04" | bc) ]]; then
    sudo apt install terminology -y
  fi
  
  sudo apt install neovim -y
  sudo apt install git -y
  sudo apt install fish -y
  sudo apt install python3-pip -y

  # Python stuff
  python3 -m pip --user install --upgrade pip
  python3 -m pip --user install setuptools

  # Node.js stuff
  sudo apt install nodejs -y
  sudo npm install -g webpack
  sudo npm install -g webpack-cli
  sudo npm install -g webpack-dev-server
  echo "Done."
else
  echo "Unknown Platform:"
  echo $(uname)
  echo "Aborting..."
  exit 1
fi

# configure git
echo "done. Configuring git..."
git config --global user.name jsmith
git config --global user.email jasmith79@gmail.com
git config --global push.default simple

# Install fira code font
# Once installed will need to set in preferences in terminology.
echo "done. Installing FiraCode font..."
cd ~
mkdir Fonts
cd Fonts
git clone https://github.com/tonsky/FiraCode.git
mkdir ~/.local/share/fonts
sudo cp -r ./FiraCode/distr/ttf/*.ttf  ~/.local/share/fonts

echo "done. Installing vim-plug..."
# install vim-plug for neovim and update neovim to use it
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

python3 -m pip --user install neovim

# Stash existing configs
echo "done. Moving old configs to ~/.old_configs..."
mkdir -p ~/.old_configs
mv -t ~/.old_configs ~/.vimrc ~/.bashrc ~/.config/nvim ~/.config/fish/config.fish

echo "done. Symlinking new configs..."
mkdir -p ~/.config ~/.config/nvim
ln -s ~/jasmith79-dotfiles/vimrc ~/.config/nvim/init.vim
ln -s ~/jasmith79-dotfiles/bashrc ~/.bashrc
ln -s ~/jasmith79-dotfiles/config.fish ~/.config/fish/config.fish
ln -s ~/jasmith79-dotfiles/vimrc ~/.vimrc

echo "done. Exiting."
