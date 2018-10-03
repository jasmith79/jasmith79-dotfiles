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

mkdir -p /opt/programs
chown -R "$user" /opt/programs

if [[ "$os" =~ [Dd]arwin ]]; then
  echo "On OS X"
  # NOTE: the rest of this assumes that you have the XCode CLI tools installed.

  # Install brew
  if ! command -v brew >/dev/null; then
    sudo -u "$user" /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  sudo -u "$user" brew tap caskroom/cask
  if ! command -v atom >/dev/null; then
    sudo -u "$user" brew cask install atom
  fi

  # iterm2 goodies
  sudo -u "$user" brew cask install iterm2
  curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
  curl https://www.iterm2.com/utilities/imgcat > /opt/programs/imgcat
  chmod +x /opt/programs/imgcat
  sudo ln -s /opt/programs/imgcat /usr/local/bin/imgcat

  # From here on its similar-ish to linux
  echo "Installing prerequisites..."
  sudo -u "$user" brew install git
  sudo -u "$user" brew install htop
  sudo -u "$user" brew install nodejs  # current LTS generally
  sudo -u "$user" brew install yarn
  sudo -u "$user" brew install python3 # also usually current, also adds pip

  # needed for java/clojure/clojurescript
  sudo -u "$user" brew cask install java
  sudo -u "$user" brew install rlwrap

  # In vagrante delicto
  sudo -u "$user" brew cask install virtualbox
  sudo -u "$user" brew cask install vagrant
  sudo -u "$user" brew cask install vagrant-manager

  # extras
  sudo -u "$user" brew install neofetch

  # Copy ssh config, High Sierra requires ssh-add -K after every reboot without it
  sudo -u "$user" ln -s $wd/ssh_config ~/.ssh/config

  # Add keychain as a git credential
  git config --global credential.helper osxkeychain
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
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    echo "Done."
  fi

  echo "Updating system repository database..."
  sudo apt-get update
  echo "Done."

  echo "Installing prerequisites..."
  sudo apt install curl gcc g++ git make cmake net-tools -y

  cd /opt/programs

  sudo apt install python3-pip -y
  sudo apt install python3-venv -y
  sudo apt install openssh-server -y
  sudo apt install vagrant -y
  sudo apt install htop -y
  sudo apt install virtualbox -y
  sudo apt install virtualbox-qt -y
  sudo apt install whois -y
  sudo apt install neofetch -y
  sudo apt install xclip -y

  # Needed for cli-visualizer
  sudo apt install libfftw3-dev libncursesw5-dev libpulse-dev -y

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

  # install google chrome browser
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
  sudo apt install google-chrome-stable

  # Extras
  sudo npm install -g vtop

  if ! [ -d /opt/programs/firefox ]; then
    cd /opt/programs
    curl -O 'https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US'
    tar xvf `find . -name 'firefox*'`
    sudo ln -s /opt/programs/firefox/firefox /usr/bin/ffdev
  fi

  sudo apt install dropbox -y
  sudo apt install vlc -y
  sudo apt install dmenu -y
  sudo apt install rofi -y
  sudo apt install nitrogen -y

  source $wd/terminology/terminology.sh
  source $wd/neogtk/neogtk.sh
  
  cd /opt/programs
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
sudo -u "$user" python3 -m pip install --upgrade pip
sudo -u "$user" python3 -m pip install --user setuptools
sudo -u "$user" python3 -m pip install --user virtualenv
sudo -u "$user" python3 -m pip install --user hangups

# Ansible
sudo -u "$user" python3 -m pip install --user ansible

source $wd/ranger/ranger.sh
source $wd/vim/vim.sh
source $wd/nvim/nvim.sh
source $wd/music/music.sh
source $wd/fish/fish.sh

# install clojure for clojurescript and clojure, plus leiningen
if ! command -v clj >/dev/null; then
  cd /opt/programs
  curl -O https://download.clojure.org/install/linux-install-1.9.0.358.sh
  chmod +x linux-install-1.9.0.358.sh
  sudo bash linux-install-1.9.0.358.sh
fi

if ! command -v lein >/dev/null; then
  cd /opt/programs
  curl -O 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
  sudo chmod a+x lein
  sudo mv lein /usr/bin
fi

# Install fonts
echo "done. Installing fonts..."
if ! [ -d "~/Fonts/FiraCode" ]; then
  mkdir -p ~/Fonts/FiraCode
  git clone https://github.com/tonsky/FiraCode.git ~/Fonts/FiraCode
  sudo git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git ~/Fonts/source-code-pro.git

  if [[ -d "/Library/Fonts" &&  ! -f "/Library/Fonts/NotoMono-Regular.ttf" ]]; then
  	# Only need this for OS X, pre-installed on ubuntu/mint
    cd ~/Fonts
  	curl https://noto-website-2.storage.googleapis.com/pkgs/NotoMono-hinted.zip > NotoMono.zip
  	unzip NotoMono.zip
  	sudo cp NotoMono-Regular.ttf /Library/Fonts
  	sudo cp -r ~/Fonts/FiraCode/distr/ttf/*.ttf /Library/Fonts
  	sudo cp -r source-code-pro /Library/Fonts
  elif [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version ]]
  then
  	sudo mkdir -p /usr/share/fonts/truetype/FiraCode
  	sudo cp -r ~/Fonts/FiraCode/distr/ttf/*.ttf  /usr/share/fonts/truetype/FiraCode
  	sudo cp -r ~/Fonts/source-code-pro /usr/share/fonts/opentype
  	sudo ln -s /usr/share/fonts/truetype/NotoMono-Regular.ttf /usr/share/terminology/fonts/
  	sudo fc-cache -f -v
  fi
fi

# Stash existing configs
echo "done. Moving old configs to ~/.old_configs..."
mkdir -p ~/.old_configs

if [ -f "~/.bashrc" ]; then
  mv ~/.bashrc ~/.old_configs
fi
rm -f ~/.bashrc

sudo chown -R "$user" ~
sudo chgrp -R "$user" ~
sudo chown -R "$user" /opt/programs
sudo chgrp -R "$user" /opt/programs

echo "done. Symlinking new configs..."
sudo -u "$user" ln -s $wd/bashrc ~/.bashrc

echo "done. Sourcing copied .bashrc"
source ~/.bashrc

echo "Finished"
