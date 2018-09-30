SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  NVIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$NVIMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
NVIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

mkdir -p ~/.vim/pack/jsmith/start
mkdir -p ~/.old_configs

# If it's an actual file we don't want to lose it
if [ -f "~/.config/nvim/init.vim" ]; then
  cp ~/.config/nvim/init.vim ~/.old_configs/init.vim
fi
rm -f ~/.config/nvim/init.vim

ln -s $NVIMDIR/init.vim ~/.config/nvim/init.vim
