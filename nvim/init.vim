set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" call plug#begin('~/.local/share/nvim/plugged')
" Plug 'Shougo/denite'
" Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
" Plug 'mhinz/vim-grepper'
" Plug 'Shougo/vimfiler.vim', { 'on': 'VimFiler' }
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'w0rp/ale'
" Plug 'lifepillar/vim-solarized8'
" call plug#end()

" ctrlP
" space t opens fuzzy finder
" noremap <Leader>t :CtrlP<CR>

" vim-grepper
" space f p for project or space f b for open buffers
" nnoremap <Leader>fp :Grepper<Space>-query<Space>
" nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>

" file tree
" space backtick to toggle ftree
" space ~ to open from current buffer's dir
" map ` :VimFiler -buffer-name=explorer -simple -wenwidth=35 -toggle -no-quit :VimFilerExplorer<CR>
" map ~ :VimFilerCurrentDir -explorer -find<CR>

" autocomplete
" let g:deoplete#enable_at_startup = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" color theme
" colorscheme solarized8_dark_flat

hi Normal guibg=NONE ctermbg=NONE

" Vimr specifics
if has("gui_vimr")
  colorscheme dracula
endif

" Neovim GTK specifics
if exists('g:GtkGuiLoaded')
  " Looks better than the other solarized variants in GUI
  colorscheme dracula

  " Set font, FiraCode looks crappy for some reason (all variants)
  call rpcnotify(1, 'Gui', 'Font', 'Noto Mono 10')

  " Enable native clipboard
  let g:GuiInternalClipboard = 1
endif
