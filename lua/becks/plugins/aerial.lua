return {
  'stevearc/aerial.nvim',
  event = "BufRead",
  opts = {
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = 'Previous symbol' })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = 'Next symbol' })
    end,
  },
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  init = function()
    vim.keymap.set("n", "<leader>i", "<cmd>AerialToggle<CR>", { desc = 'Open Aerial' })
  end
}
