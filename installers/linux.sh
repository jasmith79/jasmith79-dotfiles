#!/usr/bin/env bash

dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"
os=$(bash "$dotfiles_dir/utils/get-platform")
user=$(bash "$dotfiles_dir/utils/better-whoami")
source "$dotfiles_dir/utils/update-apt.sh"
source "$dotfiles_dir/utils/pushpop.sh"

if ! [[ "$(uname)" =~ [Ll]inux ]]; then
  echo "Trying to install Linux components on another platform, aborting!" >&2
  exit 1
fi

if [[ "$os" =~ "ubuntu" ]]; then # includes mint
  update-apt

  # I'm not going to bother writing conditionals for all of these.
  sudo apt install -y openssh-server
  sudo apt install -y virtualbox-qt
  sudo apt install -y whois
  sudo apt install -y xclip
  sudo apt install -y vlc
  sudo apt install -y nitrogen
  sudo apt install -y lolcat
  sudo apt install -y wget
  sudo apt install -y curl
  sudo apt install -y apt-transport-https

  # Dropbox
  if [ ! -d "$HOME/Dropbox" ]; then
    pushd ~ || exit 1
    wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd
    popd || exit 1
  fi

  needs_update=false
  # Google chrome
  if ! command -v chrome > /dev/null; then
    needs_update=true
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  fi

  # Brave browser
  if ! command -v brave > /dev/null; then
    needs_update=true
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  fi

  if [ "$needs_update" = true ]; then
    sudo apt-get update
    sudo apt install -y google-chrome-stable
    sudo apt install -y brave-browser
  fi

elif [[ "$os" =~ "arch" ]]; then
  echo "Not yet implemented" >&2
  exit 1
else
  echo "Unsupported linux distribution!" >&2
  exit 1
fi

# Add user to vboxsf group so if in VM can access shared folders.
sudo usermod -aG vboxsf "$user"
