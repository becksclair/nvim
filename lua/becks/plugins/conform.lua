return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  lazy = true,
  opts = {
    formtters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
    },
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

      ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
    },
  },

  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    vim.keymap.set("n", "<F3>", conform.format, { desc = "Format buffer" })
  end,
}
