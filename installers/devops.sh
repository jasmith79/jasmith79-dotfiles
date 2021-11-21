#!/usr/bin/env bash
dotfiles_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

os="$(bash "$dotfiles_dir/utils/get-platform")"

source "$dotfiles_dir/utils/ensure-brew.sh"
source "$dotfiles_dir/utils/update-apt.sh"
source "$dotfiles_dir/utils/pushpop.sh"

if ! command -v vagrant > /dev/null; then
  if [ "$os" = "Darwin" ]; then
    ensure-brew
    brew install --cask virtualbox
    brew install --cask vagrant
    brew install --cask vagrant-manager
  elif [[ "$os" =~ "ubuntu" ]]; then
    update-apt
    sudo apt install virtualbox
    pushd /tmp || exit 1
    curl -O https://releases.hashicorp.com/vagrant/2.2.19/vagrant_2.2.19_x86_64.deb
    sudo apt install ./vagrant_2.2.19_x86_64.deb
    popd || exit 1
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

if ! command -v ansible-playbook > /dev/null; then
  if ! command -v pip3 > /dev/null; then
    bash "$dotfiles_dir/installers/python.sh"
  fi

  python3 -m pip install --user ansible
fi

if ! command -v docker > /dev/null; then
  if [ "$os" = "Darwin" ]; then
    ensure-brew
    brew cask install docker
  elif [[ "$os" =~ "ubuntu" ]]; then
    update-apt
    sudo apt install -y ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

if ! command -v terraform > /dev/null; then
  if [ "$os" = "Darwin" ]; then
    ensure-brew
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
  elif [[ "$os" =~ "ubuntu" ]]; then
    update-apt
    sudo apt install -y gnupg software-properties-common curl
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

if ! command -v aws > /dev/null; then
  if [ "$os" = "Darwin" ]; then
    pushd /tmp || exit 1
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    popd || exit 1
  elif [[ "$os" =~ "ubuntu" ]]; then
    update-apt
    sudo apt install -y curl zip
    pushd /tmp || exit 1
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    popd || exit 1
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi

# Azure
if ! command -v az > /dev/null; then
  if [ "$os" = "Darwin" ]; then
    brew install azure-cli
  elif [[ "$os" =~ "ubuntu" ]]; then
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  elif [ "$os" = "arch" ]; then
    echo "Not implemented yet!" >&2
    exit 1
  else
    echo "Unsupported platform $os!" >&2
    exit 1
  fi
fi
