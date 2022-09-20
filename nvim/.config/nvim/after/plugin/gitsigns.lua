local Remap = require("jsmith.keymap")

Remap.nnoremap("<leader>tb", "<cmd>Gitsigns toggle<cr>")
require('gitsigns').setup{
  on_attach = function()
    local gs = package.loaded.gitsigns

    -- Navigation
    Remap.nnoremap(']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    Remap.nnoremap('[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    Remap.vnoremap('<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
    Remap.vnoremap('<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
    Remap.nnoremap('<leader>hS', gs.stage_buffer)
    Remap.nnoremap('<leader>hu', gs.undo_stage_hunk)
    Remap.nnoremap('<leader>hR', gs.reset_buffer)
    Remap.nnoremap('<leader>hp', gs.preview_hunk)
    Remap.nnoremap('<leader>hb', function() gs.blame_line{full=true} end)
    Remap.nnoremap('<leader>tb', gs.toggle_current_line_blame)
    Remap.nnoremap('<leader>hd', gs.diffthis)
    Remap.nnoremap('<leader>hD', function() gs.diffthis('~') end)
    Remap.nnoremap('<leader>td', gs.toggle_deleted)
  end
}

