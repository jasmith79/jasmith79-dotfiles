#!/usr/bin/bash

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

echo "Script called by user $user."

if [[ "$os" =~ [Dd]arwin ]]; then
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
  if [[ ($distro == "Ubuntu" || $distro == "LinuxMint") && $ubuntu_version && "$ubuntu_version" -lt "18" ]]; then
    sudo apt install terminology -y
    cp terminology.cfg ~/.config/terminology/config/standard/base.cfg
  fi

  sudo apt install neovim -y
  sudo apt install git -y
  sudo apt install fish -y
  sudo apt install python3-pip -y

  # Python stuff
  python3 -m pip --user install --upgrade pip
  python3 -m pip --user install setuptools

  # Node.js stuff
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
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

# Install fonts
# Once installed will need to set in preferences in terminology.
echo "done. Installing fonts..."
cd ~
mkdir Fonts
cd Fonts
git clone https://github.com/tonsky/FiraCode.git
sudo git clone --depth 1 --branch release https://github.com/adobe-fonts/source-code-pro.git
if [ -d "/Library/Fonts" ]; then
	# Only need this for OS X, pre-installed on ubuntu/mint
	curl https://noto-website-2.storage.googleapis.com/pkgs/NotoMono-hinted.zip > NotoMono.zip
	unzip NotoMono.zip
	sudo cp NotoMono-Regular.ttf /Library/Fonts
	sudo cp -r ./FiraCode/distr/ttf/*.ttf /Library/Fonts
	sudo cp -r source-code-pro /Library/Fonts
else
	sudo mkdir /usr/share/fonts/truetype/FiraCode
	sudo cp -r ./FiraCode/distr/ttf/*.ttf  /usr/share/fonts/truetype/FiraCode
	sudo cp -r source-code-pro /usr/share/fonts/opentype
	sudo ln -s /usr/share/fonts/truetype/NotoMono-Regular.ttf /usr/share/terminology/fonts/
	sudo fc-cache -f -v
fi
cd ~

echo "done. Installing vim-plug..."
# install vim-plug for neovim and update neovim to use it
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

python3 -m pip --user install neovim

# Stash existing configs
echo "done. Moving old configs to ~/.old_configs..."
mkdir -p ~/.old_configs
mv -t ~/.old_configs ~/.vimrc ~/.bashrc ~/.config/nvim ~/.config/fish/config.fish
chown -R $user ~/.old_configs

echo "done. Symlinking new configs..."
su - "$user" -c "mkdir -p ~/.config ~/.config/nvim"
su - "$user" -c "mkdir -p ~/.config/fish"
su - "$user" -c "ln -s ./vimrc ~/.config/nvim/init.vim"
su - "$user" -c "ln -s ./bashrc ~/.bashrc"
su - "$user" -c "ln -s ./config.fish ~/.config/fish/config.fish"
su - "$user" -c "ln -s ./vimrc ~/.vimrc"
echo "done. Sourcing copied .bashrc"
source ~/.bashrc
echo "done. Exiting."
