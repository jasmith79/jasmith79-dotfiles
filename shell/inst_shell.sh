#!/bin/sh

if ! command -v bash > /dev/null; then
  if command -v pkg > /dev/null; then
    sudo pkg install bash
  elif command -v apt > /dev/null
  then
    sudo apt install bash -y 
  else
    echo "Cannot install bash on this system, exiting..."
    exit 1
  fi
fi

user=$(logname)
who=$(whoami)
if [ "$user" = "" ]; then
	user="$SUDO_USER"
fi

if [ "$user" = "" ]; then
	user="$who"
fi

SHDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}; SHDIR=$(cd "$a"; pwd)

echo "$user"
echo "$SHDIR"

mkdir -p ~/.old_configs
if [ -f ~/.bashrc ]; then
  cp ~/.bashrc ~/.old_configs/.bashrc
fi

if [ -f ~/.bash_profile ]; then
  cp ~/.bashrc ~/.old_configs/.bash_profile
fi

rm -f ~/.bashrc
rm -f ~/.bash_profile
ln -s $SHDIR/bashrc ~/.bashrc
ln -s $SHDIR/bash_profile ~/.bash_profile
