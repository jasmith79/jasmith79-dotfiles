#!/bin/bash

sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake build-essential autoconf libtool xutils-dev xcb libxcb-composite0-dev doxygen -y

mkdir -p /opt/programs

if [ -d /opt/programs/i3 ]; then
  cd /opt/programs/i3
  git pull
else
  cd /opt/programs
  git clone https://github.com/Airblader/i3.git
  cd i3
  autoreconf --force --install
  rm -rf build
  mkdir -p build && cd build

  ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
  make && sudo make install
fi

sudo apt install compton feh lxappearance -y
