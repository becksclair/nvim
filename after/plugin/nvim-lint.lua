require('lint').linters_by_ft = {
  -- markdown = {'vale',},
  python = { 'flake8', 'pylint', },
  sql = { 'sqlfluff', },

  bash = { 'shellcheck', },
  shell = { 'shellcheck', },
  zsh = { 'shellcheck', },
  cpp = { 'clangtidy' },

  -- vlang = { 'vlang' },

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

-- local function parse_vlang_check(output, bufnr)
--
-- end

-- require('lint').linters.vlang = {
--   name = 'vlang',
--   cmd = 'v',
--   stdin = false,
--   args = {'-check', '.'},
--   stream = 'both',
--   ignore_exitcode = true,
--   parser = require('lint.parser').from_errorformat(errorformat),
-- }

vim.keymap.set("n", "<leader>bl", require("lint").try_lint, { desc = "Lint file" })
