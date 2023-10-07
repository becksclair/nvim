vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true, desc = 'Open quickfix' }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { silent = true, noremap = true, desc = 'Open workspace diagnostics' }
)

vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>",
  { silent = true, noremap = true, desc = 'Open references' }
)
