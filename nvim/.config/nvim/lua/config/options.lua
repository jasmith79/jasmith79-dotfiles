vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
-- use system clipboard. On windows should be unnamed instead of unnamedplus
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
-- don't need this in neovim?
-- vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 120

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- default is too low, breaks comment.nvim among other things
vim.timeoutlen = 1000
vim.opt.background = "dark"

-- stylua enforces tabs, so fine I guess I'll set tabstop
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- prevents the insertion of newlines in freeform text like markdown files
-- see :help fo-table for all the options
vim.opt.formatoptions:remove("t")
