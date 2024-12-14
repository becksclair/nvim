return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  lazy = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Conform will run the first available formatter
      javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
      typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
      json = { "biome", "prettierd", "prettier", stop_after_first = true },
      svelte = { "prettierd", lsp_format = "fallback" },
      css = { "prettierd", lsp_format = "fallback" },

    },
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    vim.keymap.set("n", "<F3>", conform.format, { desc = "Format buffer" })
  end,
}
