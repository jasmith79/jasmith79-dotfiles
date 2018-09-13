#!/usr/bin/bash

# Determine working directory
wd=$(pwd)

if [[ $wd = "" ]]; then
  echo "Cannot determine working directory, aborting..."
  exit 1
fi

# Determine operating system
os=$(uname)
echo "Operating System: $os"

# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
	user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
	user="$who"
fi

echo "Script called by user $user in directory $wd."

if [[ "$os" =~ [Dd]arwin ]]; then
  echo "On OS X"
  # NOTE: the rest of this assumes that you have the XCode CLI tools installed.

  # Install brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask
  brew cask install atom

  # From here on its similar-ish to linux, but yah know, OS X isn't super terminal-friendly
  echo "Installing prerequisites...as far as we can in OS X anyway..."
  brew install fish
  brew install neovim
  brew install git
  brew install nodejs  # current LTS generally
  brew install python3 # also usually current

  sudo apt install openssh-server -y

  # needed for java/clojure/clojurescript
  brew cask install java
  brew install rlwrap

  # In vagrante delicto
  brew cask install virtualbox
  brew cask install vagrant
  brew cask install vagrant-manager

  # extras
  brew install cmus
  brew install ranger
  echo "Done."

elif [[ "$os" =~ [Ll]inux ]]
then
  # For now, we're assuming "Linux" means Ubuntu or Mint
  # TODO: rework for yum/pacman later.
  ubuntu_version=false
  distro=$(cat /etc/lsb-release | head -n 1 | grep -o "=[a-zA-Z]\+" | cut -c2-)
  if [ $distro == "LinuxMint" ]; then
    ubuntu_version=$(cat /etc/upstream-release/lsb-release | grep -o "[0-9]\{2\}" | head -n 1)
  elif [ $distro == "Ubuntu" ]
  then
    ubuntu_version=$(cat /etc/lsb-release | grep -o "[0-9]\{2\}" | head -n 1)
  else
    echo "Unknown Linux Distro:"
    echo "$distro"
    echo "Aborting..."
    exit 1
  fi
  echo "Distro: $distro"
  version=$(cat /etc/lsb-release | grep -o "[0-9]\{2\}\.[0-9]\{2\}" | head -n 1)
  echo "Version $version"
  if [[ $ubuntu_version != 0 ]]; then
    echo "Ubuntu derivative based on $ubuntu_version.x"
  fi

  if [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version && "$ubuntu_version" -lt "18" ]]; then
    echo "Older Ubuntu base detected. Adding ppas..."
    sudo add-apt-repository ppa:enlightenment-git/ppa -y
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    echo "Done."
  fi

  echo "Updating system repository database..."
  sudo apt-get update
  echo "Done."

  echo "Installing prerequisites..."
  sudo apt install curl -y

  # NOTE: the PPA doesn't work for e.g. 18.04 meaning you'll get the older version of
  # terminology from the repos
  # TODO: instructions to install dependencies, grab github repo, and build if no PPA
  if [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version ]]; then
    sudo apt install terminology -y
    cp terminology.cfg ~/.config/terminology/config/standard/base.cfg
  fi

  sudo apt install net-tools -y
  sudo apt install neovim -y
  sudo apt install gcc -y
  sudo apt install make -y
  sudo apt install git -y
  sudo apt install fish -y
  sudo apt install python3-pip -y
  sudo apt install python3-venv -y
  sudo apt install openssh-server -y
  sudo apt install vagrant -y

  # needed for java/clojure/clojurescript
  sudo apt install default-jdk -y
  sudo apt install rlwrap -y

  # Node.js stuff
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt install nodejs -y
  echo "Done."

  # install yarn package manager for frontend
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update && sudo apt install yarn -y

  # install atom editor
  curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
  sudo apt-get update
  sudo apt install atom -y

  # Extras
  if ! [ -d /opt/programs/ranger ]; then
    su - $user -c "git clone https://github.com/ranger/ranger.git /opt/programs/ranger"
  fi

  if [ command -v ranger >/dev/null 2>&1 ]; then
    cd /opt/programs/ranger
    sudo make install
    su - $user -c "ranger --copy-config=all"
    rm ~/.config/ranger/rc.conf
    su - $user -c "ln -s $wd/rc.conf ~/.config/ranger/rc.conf"
  fi

  sudo apt install cmus -y
  sudo apt install dropbox -y
  sudo apt install vlc -y

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

# Node stuff
npm install -g webpack
npm install -g webpack-cli
npm install -g webpack-dev-server

# Python stuff
su - "$user" -c "python3 -m pip install --upgrade pip"
su - "$user" -c "python3 -m pip install --user setuptools"

# Extras
mkdir -p /opt/programs
chown -R $user /opt/programs

# install clojure for clojurescript and clojure
curl -O https://download.clojure.org/install/linux-install-1.9.0.358.sh
chmod +x linux-install-1.9.0.358.sh
sudo bash linux-install-1.9.0.358.sh
if [ command -v lein >dev/null 2>&1 ]; then
  curl -O 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
  sudo chmod a+x lein
  sudo mv lein /usr/bin
  su - $user -c "lein"
fi

# Install fonts
echo "done. Installing fonts..."
mkdir -p ~/Fonts/FiraCode
git clone https://github.com/tonsky/FiraCode.git ~/Fonts/FiraCode
sudo git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git ~/Fonts/source-code-pro.git
if [ -d "/Library/Fonts" ]; then
	# Only need this for OS X, pre-installed on ubuntu/mint
  cd ~/Fonts
	curl https://noto-website-2.storage.googleapis.com/pkgs/NotoMono-hinted.zip > NotoMono.zip
	unzip NotoMono.zip
	sudo cp NotoMono-Regular.ttf /Library/Fonts
	sudo cp -r ~/Fonts/FiraCode/distr/ttf/*.ttf /Library/Fonts
	sudo cp -r source-code-pro /Library/Fonts
  cd $wd
elif [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version ]]
then
	sudo mkdir -p /usr/share/fonts/truetype/FiraCode
	sudo cp -r ~/Fonts/FiraCode/distr/ttf/*.ttf  /usr/share/fonts/truetype/FiraCode
	sudo cp -r ~/Fonts/source-code-pro /usr/share/fonts/opentype
	sudo ln -s /usr/share/fonts/truetype/NotoMono-Regular.ttf /usr/share/terminology/fonts/
	sudo fc-cache -f -v
fi

echo "done. Installing vim-plug..."
# install vim-plug for neovim and update neovim to use it
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

su - "$user" -c "python3 -m pip install --user neovim"

# Stash existing configs
echo "done. Moving old configs to ~/.old_configs..."
mkdir -p ~/.old_configs
mv -t ~/.old_configs ~/.vimrc ~/.bashrc ~/.config/nvim ~/.config/fish/config.fish
chown -R $user ~

echo "done. Symlinking new configs..."

su - "$user" -c "mkdir -p ~/.config ~/.config/nvim"
su - "$user" -c "mkdir -p ~/.config/fish"
su - "$user" -c "ln -s $wd/init.vim ~/.config/nvim/init.vim"
su - "$user" -c "ln -s $wd/bashrc ~/.bashrc"
su - "$user" -c "ln -s $wd/config.fish ~/.config/fish/config.fish"
su - "$user" -c "ln -s $wd/vimrc ~/.vimrc"
echo "done. Sourcing copied .bashrc"
source ~/.bashrc
echo "done. Starting fish shell."
fish
