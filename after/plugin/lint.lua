require('lint').linters_by_ft = {
  -- markdown = {'vale',},
  python = { 'flake8', 'pylint', },
  sql = { 'sqlfluff', },

  bash = { 'shellcheck', },
  shell = { 'shellcheck', },
  zsh = { 'shellcheck', },
  -- rust = { 'clippy' }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require('lint').linters.shellcheck.args = {
  '-s',
  'bash',
  '--format',
  'json',
  '-'
}

vim.keymap.set("n", "<leader>bl", require("lint").try_lint, { desc = "Lint file" })

