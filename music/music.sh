
# Determine current user
user=$(logname)
who=$(whoami)
if [[ $user = "" ]]; then
	user="$SUDO_USER"
fi

if [[ $user = "" ]]; then
	user="$who"
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  MUSDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$MUSDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
MUSDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

mkdir -p /opt/programs
mkdir -p ~/.old_configs
mkdir -p ~/.config/cmus ~/.config/vis/colors


if ! command -v cmus > /dev/null; then
  if command -v apt > /dev/null; then
    sudo apt install cmus -y
  elif command -v brew > /dev/null; then
    brew install cmus
  else
    echo "Unable to install cmus!"
  fi
fi

if [ -d /opt/programs/cli-visualizer ]; then
  cd /opt/programs/cli-visualizer
  git pull
else
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install fftw
    sudo -u "$user" brew tap homebrew/dupes
    sudo -u "$user" brew install ncurses
  elif command -v apt > /dev/null; then
    sudo apt install libfftw3-dev libncursesw5-dev libpulse-dev -y
    cd /opt/programs
    git clone https://github.com/dpayne/cli-visualizer.git
    cd cli-visualizer
    ./install.sh
  else
    echo "Unable to install cli-visualizer!"
  fi
fi

if [ -f ~/.config/cmus/rc ]; then
  cp ~/.config/cmus/rc ~/.old_configs/cmus.conf
fi

if [ -f ~/.config/vis/config ]; then
  cp ~/.config/vis/config ~/.old_configs/vis.conf
fi

rm -f ~/.config/cmus/rc ~/.config/vis/config ~/.config/vis/colors/bluey
ln -s $MUSDIR/config.cmus ~/.config/cmus/rc
ln -s $MUSDIR/vis.conf ~/.config/vis/config
ln -s $MUSDIR/bluey ~/.config/vis/colors/bluey
