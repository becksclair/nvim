if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
  -- vim.g.neovide_refresh_rate = 120
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_transparency = 0.9

  vim.opt.linespace = 2

  -- vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  -- vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  -- vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  -- vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  -- vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  -- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end
