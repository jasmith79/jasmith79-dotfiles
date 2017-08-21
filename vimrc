" jasmith79's .vimrc for neovim

" we'll add a plugin instead of the standard modeline
set nomodeline
set encoding=utf8

" be sure to use vim instead of vi settings
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" mice and men
if has('mouse')
  set mouse=a
endif

syntax on
colorscheme solarized
set background=dark

" tabs are icky, set to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" mind in the gutter
set number

let mapleader="\<SPACE>"

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
map ` :VimFiler -explorer<CR>
map ~ :VimFilerCurrentDir -explorer -find<CR>

" autocomplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
