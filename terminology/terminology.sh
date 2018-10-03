#!/bin/bash
# Installs terminology terminal emulator and dependencies from source.

# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
	user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
	user="$who"
fi

mkdir -p /opt/programs

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TERMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$TERMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
TERMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

mkdir -p /opt/programs
if ! command -v terminology >/dev/null; then
  cd /opt/programs

  sudo apt install -y meson check libssl-dev libsystemd-dev libjpeg-dev libglib2.0-dev libgstreamer1.0-dev libluajit-5.1-dev libfreetype6-dev libfontconfig1-dev libfribidi-dev libx11-dev libxext-dev libxrender-dev libgl1-mesa-dev libgif-dev libtiff5-dev libpoppler-dev libpoppler-cpp-dev libspectre-dev libraw-dev librsvg2-dev libudev-dev libmount-dev libdbus-1-dev libpulse-dev libsndfile1-dev libxcursor-dev libxcomposite-dev libxinerama-dev libxrandr-dev libxtst-dev libxss-dev libbullet-dev libgstreamer-plugins-base1.0-dev doxygen

  cd /opt/programs
  curl -O https://download.enlightenment.org/rel/libs/efl/efl-1.20.7.tar.xz
  tar xvf efl-1.20.7.tar.xz
  cd efl-1.20.7/
  ./configure
  make
  sudo make install
  sudo ln -s /usr/local/share/dbus-1/services/org.enlightenment.Ethumb.service /usr/share/dbus-1/services/org.enlightenment.Ethumb.service
  sudo ldconfig
  cd /opt/programs

  curl -O https://download.enlightenment.org/rel/apps/terminology/terminology-1.2.1.tar.xz
  tar xvf terminology-1.2.1.tar.xz
  cd terminology-1.2.1
  meson build
  cd build
  ninja
  sudo ninja install
fi

mkdir -p ~/.config/terminology/config/standard
mkdir -p ~/.old_configs

# If it's an actual file we don't want to lose it
if [ -f "~/.config/terminology/config/standard/base.cfg" ]; then
  cp ~/.config/terminology/config/standard/base.cfg /.old_configs/terminology.cfg
fi
rm -f ~/.config/terminology/config/standard/base.cfg

ln -s $TERMDIR/terminology.cfg ~/.config/terminology/config/standard/base.cfg

chown -R "$user" /opt/programs
chown -R "$user" ~
