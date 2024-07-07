vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  { silent = true, noremap = true, desc = 'Open quickfix' }
)
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble workspace_diagnostics<cr>",
  { silent = true, noremap = true, desc = 'Open workspace diagnostics' }
)

vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>",
  { silent = true, noremap = true, desc = 'Open references' }
)
