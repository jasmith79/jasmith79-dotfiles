local Remap = require("jsmith.keymap")
Remap.nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
Remap.nnoremap("<leader>fw", "<cmd>Telescope live_grep<cr>")
Remap.nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
Remap.nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
Remap.nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>")

