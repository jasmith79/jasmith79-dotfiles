local Remap = require("config.remap")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Open netrw
Remap.nnoremap("<leader>fp", "<cmd>Ex<CR>")

-- When pasting over highlighted text, this will maintain
-- the paste buffer instead of overwriting its contents with
-- the copied-over text.
Remap.xnoremap("<leader>p", '"_dP')

-- Open buffer list with spaceb, type name to jump
Remap.nnoremap("<Leader>b", ":buffers<CR>:buffer<Space>")

-- Make Y work like D, C
Remap.nnoremap("Y", "yg$")

-- nice undo semantics
Remap.inoremap(",", ",<c-g>u")
Remap.inoremap(".", ".<c-g>u")
Remap.inoremap("?", "?<c-g>u")
Remap.inoremap("!", "!<c-g>u")
Remap.inoremap("[", "[<c-g>u")
Remap.inoremap("]", "]<c-g>u")
Remap.inoremap("{", "{<c-g>u")
Remap.inoremap("}", "}<c-g>u")
Remap.inoremap("(", "(<c-g>u")
Remap.inoremap(")", ")<c-g>u")

-- MOVEMENT
-- Remap cursor movement for colemak, l is fine as is.
Remap.nnoremap("j", "h")
Remap.nnoremap("h", "k")
Remap.nnoremap("k", "j")
Remap.vnoremap("j", "h")
Remap.vnoremap("h", "k")
Remap.vnoremap("k", "j")

-- Move Blocks of highlighted text, autoindenting
Remap.vnoremap("H", ":m '>+1<CR>gv=gv")
Remap.vnoremap("J", ":m '<-2<CR>gv=gv")

-- Make jumps more natural. n/N next/prev result, zz center cursor, zv open folds
Remap.nnoremap("n", "nzzzv")
Remap.nnoremap("N", "Nzzzv")

-- Use a mark to recenter cursor when concatenating lines
Remap.nnoremap("J", "mzJ`z")

Remap.inoremap("<C-c>", "<Esc>")

-- This is for JS/TS unit tests, it will toggle on/off the test(s) on the
-- line/visual selection.
Remap.vnoremap(
	"<Leader>tt",
	":s/ it(/ zzit(/ge<CR>gv:s/ xit(/ yyit(/ge<CR>gv:s/ zzit/ xit/ge<CR>gv:s/ yyit/ it/ge<CR>i<Esc>"
)
Remap.nnoremap("<Leader>tt", ":s/ it(/ zzit(/e<CR>:s/ xit(/ yyit(/e<CR>:s/ zzit/ xit/e<CR>:s/ yyit/ it/e<CR>i<Esc>")

-- Stay in visual mode when moving text blocks
Remap.vnoremap("<", "<<CR>gv")
Remap.vnoremap(">", "><CR>gv")

-- Select entire file
Remap.nnoremap("<Leader>sa", "ggVG")

-- ESC input mode in terminal
Remap.tnoremap("<Esc>", "<C-\\><C-n>")

-- easier word substitution
Remap.nnoremap("<Leader>ss", ":%s/")
Remap.vnoremap("<Leader>ss", ":s/")

-- open term in vspl
Remap.nnoremap("<Leader>te", "<cmd>vsp<CR><cmd>term<CR>i")

-- keep split switch in term
Remap.tnoremap("<C-w><C-w>", "<C-\\><C-n><C-w><C-w>")
