#!/bin/bash

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
echo "Home is $HOME"

mkdir -p /opt/programs
chown -R "$user" /opt/programs


sudo apt install libatk1.0-dev libcairo2-dev libgdk-pixbuf2.0-dev libglib2.0-dev libgtk-3-dev libpango1.0-dev -y
if ! [ -d ~/.cargo ]; then
  cd /tmp
  sudo -u "$user" curl https://sh.rustup.rs -sSfo /tmp/rustup
  sudo -u "$user" sh /tmp/rustup -y
fi

if [ -f ~/.cargo/env ]; then
  echo "Sourcing cargo/env"
  source ~/.cargo/env
else
  echo "Cargo env not available for sourcing, aborting"
  exit 1
fi

if [ -d /opt/programs/neovim-gtk ]; then
  cd /opt/programs/neovim-gtk
  git pull
else
  cd /opt/programs/
  sudo -u "$user" git clone https://github.com/daa84/neovim-gtk.git  
  cd neovim-gtk
fi

cargo build --release

if [ -f /opt/programs/neovim-gtk/target/release/nvim-gtk ]; then
  sudo rm -f /usr/local/bin/nvim-gtk
  sudo ln -s /opt/programs/neovim-gtk/target/release/nvim-gtk /usr/local/bin/nvim-gtk
else
  echo "No build file for neovim-gtk, aborting."
  exit 1
fi

# Build process is supposed to take care of this, but whateves. Enables use of NG* commands.
rm -f /usr/share/nvim/runtime/plugin/nvim_gui_shim.vim
sudo ln -s /opt/programs/neovim-gtk/runtime/plugin/nvim_gui_shim.vim /usr/share/nvim/runtime/plugin/nvim_gui_shim.vim
