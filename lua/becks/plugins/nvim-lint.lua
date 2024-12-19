return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = "BufReadPost",
  opts = {
    linters = {
      shellcheck = {
        args = {
          '-s',
          'bash',
          '--format',
          'json',
          '-'
        }
      }
    },

    linters_by_ft = {
      -- markdown = {'vale',},
      -- python = { 'flake8', 'pylint', },
      python = { 'ruff' },
      sql = { 'sqlfluff', },

      bash = { 'shellcheck', },
      shell = { 'shellcheck', },
      zsh = { 'shellcheck', },
      cpp = { 'clangtidy' },

      -- yaml = { 'cfn_lint' },

      -- vlang = { 'vlang' },

      -- rust = { 'clippy' }
    }
  },

  config = function(_, opts)
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>bl", require("lint").try_lint, { desc = "Lint file" })
  end,
}
