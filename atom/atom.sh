#!/bin/bash
os=$(uname)

if ! command -v atom > /dev/null; then
  if [[ "$os" =~ [Dd]arwin ]]; then
    sudo -u "$user" brew cask install atom
  elif [[ "$os" =~ [Ll]inux ]]
    curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt-get update
    sudo apt install atom -y
  fi
fi
