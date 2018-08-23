#!/usr/bin/bash

# This is geared for ubuntu and friends. Will probably do a version for OS X,
# *maybe* yum-based distros.

# prereqs
echo "Updating system repository database..."
sudo apt-get update
echo "done. Installing prerequisites..."
sudo apt-get install git -y
sudo apt-get install fish -y
sudo apt-get install python3-pip -y
sudo pip3 install --upgrade pip
sudo pip3 install setuptools
sudo add-apt-repository ppa:enlightenment-git/ppa -y
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install -g webpack
sudo npm install -g webpack-dev-server

# configure git
echo "done. Configuring git..."
git config --global user.name jsmith
git config --global user.email jasmith79@gmail.com
git config --global push.default simple

# Install terminology terminal emulator. "Official ubuntu repo is *very* outdated
# Once installed set the theme to solarized in preferences.
echo "done. Installing terminology..."
sudo apt-get install terminology -y

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
	sudo fc-cache -f -v
fi
cd ~

# Install neovim
# NOTE: added to universe repo with 17.04, next LTS shouldn't need the ppa
echo "done. Installing neovim and vim-plug..."
sudo apt-get install neovim -y

# install vim-plug for neovim and update neovim to use it
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo pip3 install neovim

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
