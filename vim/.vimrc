" jasmith79's .vimrc
" Also sourced by init.vim for neovim

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
" set smartcase
" set ignorecase

set scrolloff=8

set signcolumn=yes " Extra column for error/linter msg
set colorcolumn=80 " cursor guide at 80 char

" don't redraw during macros
set lazyredraw

" mice and men
if has('mouse')
  set mouse=a
endif

syntax on
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Don't keep search results highlighted after moving on
set nohlsearch

" Source local .vimrc if present when opening a dir
set exrc

" use system clipboard. On windows should be unnamed instead of unnamedplus
set clipboard=unnamedplus

" change the default splitting behavior to something more sensible
set splitbelow
set splitright

" ensures that editing a new buffer doesn't close the current one
set hidden

" automatically leave insert mode after 'updatetime' milliseconds of inaction
" au CursorHoldI * stopinsert
" au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
" au InsertLeave * let &updatetime=updaterestore

" tabs are icky, set to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" mind in the gutter
set number

" show matches while typing search pattern
set incsearch

set cmdheight=3

" soft wrap at 120 chars
set textwidth=120

set autoindent
set smartindent

" Make Y work like D, C
nnoremap Y yg$

" nice undo semantics
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u

" MOVEMENT
" Remap cursor movement for colemak, l is fine as is.
nnoremap j h
nnoremap h k
nnoremap k j
vnoremap j h
vnoremap h k
vnoremap k j

" Move Blocks of highlighted text, autoindenting
vnoremap H :m '>+1<CR>gv=gv 
vnoremap J :m '<-2<CR>gv=gv

" Make jumps more natural. n/N next/prev result, zz center cursor, zv open folds
nnoremap n nzzzv
nnoremap N Nzzzv

" Use a mark to recenter cursor when concatenating lines
nnoremap J mzJ`z

" COLORS

set background=dark
colorscheme iceberg

" use 24 bit color if avail
if $COLORTERM == 'truecolor'
  if (has("termguicolors"))
    set termguicolors
  endif

  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" FUNCTIONS

" Taken from https://stackoverflow.com/a/5636941/3757232
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      vertical resize 50
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" " KEYBINDINGS

" " backspace kill word. NOTE: the autopairs plugin has some functionality
" " that it executes when backspacing over a pair character e.g. {[()]} that
" " prevents then binding from working properly. Solution is to disable that
" " part of the plugin, then add its function call to my own mapping.
" let g:AutoPairsMapBS = 0
" " if empty(glob('~/.vim/pack/jsmith/start/auto-pairs'))
" if exists('g:AutoPairs')
"   inoremap <silent> <BS> <C-R>=AutoPairsDelete()<CR><C-W>
"   inoremap <silent> <Del> <C-R>=AutoPairsDelete()<CR><C-W>
" else
"   inoremap <BS> <C-W>
"   inoremap <Del> <C-W>
" endif

let mapleader="\<SPACE>"

" " Arrows to no-op
" " recommend doing until finger nav easy
" " nnoremap <Left> <Nop>
" " nnoremap <Up> <Nop>
" " nnoremap <Down> <Nop>
" " nnoremap <Right> <Nop>

" " vnoremap <Left> <Nop>
" " vnoremap <Up> <Nop>
" " vnoremap <Down> <Nop>
" " vnoremap <Right> <Nop>

map <Leader>f :call ToggleVExplorer()<CR>

" " Hit enter in the file browser to open the selected
" " file with :vsplit to the right of the browser.
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
