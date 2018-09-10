" jasmith79's .vimrc for neovim

" we'll add a plugin instead of the standard modeline
set nomodeline
set encoding=utf8
filetype plugin indent on

" be sure to use vim instead of vi settings
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" highlights matching [({
set showmatch

" autoreload when something else changes the file
set autoread

" make the search ignore case unless caps are present
set ignorecase
set smartcase

" don't redraw during macros
set lazyredraw

" mice and men
if has('mouse')
  set mouse=a
endif

syntax on

" use system clipboard. On windows should be unnamed instead of unnamedplus
set clipboard=unnamedplus

" change the default splitting behavior to something more sensible
set splitbelow
set splitright

" ensures that editing a new buffer doesn't close the current one
set hidden

" tabs are icky, set to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" mind in the gutter
set number

set cmdheight=2

inoremap fp <ESC>
let mapleader="\<SPACE>"

" Remap cursor movement for colemak, l is fine as is.
nnoremap j h
nnoremap h k
nnoremap k j

" Arrows to no-op
noremap <Left> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Right> <Nop>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/unite.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mhinz/vim-grepper'
Plug 'Shougo/vimfiler.vim', { 'on': 'VimFiler' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'lifepillar/vim-solarized8'
call plug#end()

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
set laststatus=2

" ctrlP
" space t opens fuzzy finder
nnoremap <Leader>t :CtrlP<CR>

" vim-grepper
" space f p for project or space f b for open buffers
nnoremap <Leader>fp :Grepper<Space>-query<Space>
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

" file tree
" space backtick to toggle ftree
" space ~ to open from current buffer's dir
map ` :VimFiler -buffer-name=explorer -simple -wenwidth=35 -toggle -no-quit :VimFilerExplorer<CR>
map ~ :VimFilerCurrentDir -explorer -find<CR>

" autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" color theme
colorscheme solarized8_dark_flat
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

hi Normal guibg=NONE ctermbg=NONE
