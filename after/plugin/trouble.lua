require('trouble').setup({
  icons = true,
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true }
)
