#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  ATOMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$ATOMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
ATOMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
os=$(uname)

if ! command -v atom > /dev/null; then
  if [[ "$os" =~ [Dd]arwin ]]; then
    sudo -u "$user" brew cask install atom
  elif [[ "$os" =~ [Ll]inux ]]
  then
    curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
    sudo apt-get update
    sudo apt install atom -y
  else
    echo "Unknown platform!"
  fi
fi

apm install --packages-file $ATOMDIR/packages.txt 
