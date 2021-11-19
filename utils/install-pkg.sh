# Installs a package in a cross-platform way.
# I can't use this everywhere because sometimes
# either the package name is different on different
# platforms or I want to install slightly different
# packages depending on the platform but this
# works well enough.
os=$(uname)

# From https://stackoverflow.com/a/246128/3757232
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done
utils_dir="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Ensure if on MacOS that we have homebrew
if [[ "$os" =~ [Dd]arwin ]]; then
  source "$utils_dir/ensure-brew.sh"
  ensure-brew
fi

install-pkg () {
  if command -v brew > /dev/null; then
    sudo -u "$user" brew install $1
  elif command -v apt > /dev/null; then
    source "$utils_dir/update_apt.sh"
    update_apt
    sudo apt install $1 -y
  else
    echo "Unable to install $1, unrecognized platform. Aborting..."
    exit 1
  fi
}
