SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  VIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$VIMDIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
VIMDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"

mkdir -p ~/.vim/pack/jsmith/start
mkdir -p ~/.old_configs

if [ -d ~/.vim/pack/jsmith/start/tcomment_vim ]; then
  cd ~/.vim/pack/jsmith/start/tcomment_vim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tomtom/tcomment_vim.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-airline ]; then
  cd ~/.vim/pack/jsmith/start/vim-airline
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/vim-airline/vim-airline.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-airline-themes ]; then
  cd ~/.vim/pack/jsmith/start/vim-airline-themes
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/vim-airline/vim-airline-themes.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-eunuch ]; then
  cd ~/.vim/pack/jsmith/start/vim-eunuch
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/vim-eunuch.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-fireplace ]; then
  cd ~/.vim/pack/jsmith/start/vim-fireplace
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-fireplace.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-fugitive ]; then
  cd ~/.vim/pack/jsmith/start/vim-fugitive
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-fugitive.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-repeat ]; then
  cd ~/.vim/pack/jsmith/start/vim-repeat
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-repeat.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-surround ]; then
  cd ~/.vim/pack/jsmith/start/vim-surround
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/tpope/vim-surround.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-gitgutter ]; then
  cd ~/.vim/pack/jsmith/start/vim-gitgutter
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/airblade/vim-gitgutter.git
fi

if [ -d ~/.vim/pack/jsmith/start/vim-multiple-cursors ]; then
  cd ~/.vim/pack/jsmith/start/vim-multiple-cursors
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/terryma/vim-multiple-cursors.git
fi

if [ -d ~/.vim/pack/jsmith/start/denite.nvim ]; then
  cd ~/.vim/pack/jsmith/start/denite.nvim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/Shougo/denite.nvim.git
fi

if [ -d ~/.vim/pack/jsmith/start/deoplete.nvim ]; then
  cd ~/.vim/pack/jsmith/start/deoplete.nvim
  git pull
else
  cd ~/.vim/pack/jsmith/start
  git clone https://github.com/Shougo/deoplete.nvim.git
fi

# If it's an actual file, save it
if [ -f "~/.vimrc" ]; then
  cp ~/.vimrc ~/.old_configs/.vimrc
fi
rm -f ~/.vimrc

ln -s $VIMDIR/vimrc ~/.vimrc

