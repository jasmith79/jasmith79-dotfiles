vim.opt.nu = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.exptandtab = true
vim.opt.hlsearch = false
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.textwidth = 120
vim.opt.shortmess:append("c") -- Needed for nvim-cmp completion
vim.g.mapleader = " "

-- don't need these in neovim?
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true
-- use system clipboard. On windows should be unnamed instead of unnamedplus
vim.opt.clipboard = "unnamedplus"

-- show matches while typing search pattern
-- think this is on by default in neovim?
-- vim.opt.incsearch = true

-- highlights matching [({
vim.opt.showmatch = true

-- keep minimun of 4 lines visible on either side of cursor
vim.opt.scrolloff = 4

