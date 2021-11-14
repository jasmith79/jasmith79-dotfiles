set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" we'll add a plugin instead of the standard modeline
set nomodeline

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" copied mostly from ThePrimeagen, few alterations of my own
Plug 'neovim/nvim-lspconfig' " lsp configs
Plug 'hrsh7th/cmp-nvim-lsp'  " completion engine, lsp based
Plug 'hrsh7th/cmp-buffer'    " completion engine, lsp based
Plug 'hrsh7th/nvim-cmp'      " completion engine, lsp based
Plug 'hrsh7th/cmp-path'      " path completion
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' } " moar completion
" Plug 'onsails/lspkind-nvim'  " adds cutesy images in autocompletions like vscode does
Plug 'glepnir/lspsaga.nvim'  " brings up jump to def/jump to ref UI
Plug 'simrat39/symbols-outline.nvim' " symbol tree ui
" Plug 'simrat39/rust-tools.nvim' " needed for rust analyzer plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better syntax highlighting
Plug 'nvim-treesitter/playground' " AST visualizer
" Plug 'rafamadriz/friendly-snippets' " pretty much every language I use
" Plug 'rust-lang/rust.vim' " rust lang support
" Plug 'fatih/vim-go' " golang
" Plug 'tpope/vim-fugitive' " git integration
" Plug 'tpope/vim-rhubarb' " github integration
" Plug 'junegunn/gv.vim' " git commit browser
" Plug 'vim-utils/vim-man' " browse man pages in vim
" Plug 'mbbill/undotree' " what it says on the tin, view your undo list
" Plug 'tpope/vim-dispatch' " run async jobs e.g. compile, test in new window or whatever
" Plug 'nvim-lua/popup.nvim' " required for telescope fzf
" Plug 'nvim-lua/plenary.nvim' " required for telescope fzf
" Plug 'nvim-telescope/telescope.nvim' " fzf
" Plug 'nvim-telescope/telescope-fzy-native.nvim' " fzf
" Plug 'mhinz/vim-rfc' " required for harpoon
" Plug 'ThePrimeagen/harpoon' " requires nvim-lua/plenary.nvim, custom marks
Plug 'vim-airline/vim-airline' " statusline upgrade
Plug 'vim-airline/vim-airline-themes'
Plug 'gkeep/iceberg-dark' " dark iceberg theme for airline
Plug 'dracula/vim', { 'as': 'dracula' } " shiny!

call plug#end()

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" from https://github.com/sharksforarms/vim-rust/blob/master/neovim-init-lsp-cmp-rust-tools.vim
" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
" Avoid showing extra messages when using completion
set shortmess+=c

lua require('config')
lua require'treesitter.nvim.configs'.setup { ensure_installed = "maintained", highlight = { enable = true } }

hi Normal guibg=NONE ctermbg=NONE

let g:airline_theme = 'icebergDark'

" Vimr specifics
" if has("gui_vimr")
"   colorscheme dracula
" endif

" " Neovim GTK specifics
" if exists('g:GtkGuiLoaded')
"   " Looks better than the other solarized variants in GUI
"   colorscheme dracula

"   " Set font, FiraCode looks crappy for some reason (all variants)
"   call rpcnotify(1, 'Gui', 'Font', 'Noto Mono 10')

"   " Enable native clipboard
"   let g:GuiInternalClipboard = 1
" endif
