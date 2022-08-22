#!/usr/bin/env bash
# Installs ranger file manager and configs.

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
  RNGRDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$RNGRDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
RNGRDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"


if ! [ -d /opt/programs/ranger ]; then
  git clone https://github.com/ranger/ranger.git /opt/programs/ranger
fi

if ! command -v ranger >/dev/null; then
  cd /opt/programs/ranger
  sudo make install
fi

# configure ranger
echo "done, Configuring ranger..."
sudo -u "$user" ranger --copy-config=all
rm ~/.config/ranger/rc.conf ~/.config/ranger/rifle.conf
sudo -u "$user" ln -s $RNGRDIR/rc.conf ~/.config/ranger/rc.conf
sudo -u "$user" ln -s $RNGRDIR/rifle.conf ~/.config/ranger/rifle.conf

chown -R "$user" /opt/programs
