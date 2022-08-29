local Remaps = require("jsmith.keymap")

-- Open netrw
Remaps.nnoremap("<leader>fp", "<cmd>Ex<CR>")

-- Open buffer list with spaceb, type name to jump
Remaps.nnoremap("<Leader>b", ":buffers<CR>:buffer<Space>")

>>>>>>> c2bdd79 (Add updated neovim lua config)
-- Make Y work like D, C
Remaps.nnoremap("Y", "yg$")

-- nice undo semantics
Remaps.inoremap(",", ",<c-g>u")
Remaps.inoremap(".", ".<c-g>u")
Remaps.inoremap("?", "?<c-g>u")
Remaps.inoremap("!", "!<c-g>u")
Remaps.inoremap("[", "[<c-g>u")
Remaps.inoremap("]", "]<c-g>u")
Remaps.inoremap("{", "{<c-g>u")
Remaps.inoremap("}", "}<c-g>u")
Remaps.inoremap("(", "(<c-g>u")
Remaps.inoremap(")", ")<c-g>u")

-- MOVEMENT
-- Remap cursor movement for colemak, l is fine as is.
Remaps.nnoremap("j", "h")
Remaps.nnoremap("h", "k")
Remaps.nnoremap("k", "j")
Remaps.vnoremap("j", "h")
Remaps.vnoremap("h", "k")
Remaps.vnoremap("k", "j")

-- Move Blocks of highlighted text, autoindenting
Remaps.vnoremap("H :m", "'>+1<CR>gv=gv ")
Remaps.vnoremap("J :m", "'<-2<CR>gv=gv")

-- Make jumps more natural. n/N next/prev result, zz center cursor, zv open folds
Remaps.nnoremap("n", "nzzzv")
Remaps.nnoremap("N", "Nzzzv")

-- Use a mark to recenter cursor when concatenating lines
Remaps.nnoremap("J", "mzJ`z")

Remaps.inoremap("<C-c>", "<Esc>")
