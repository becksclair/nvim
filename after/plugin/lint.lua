require('lint').linters_by_ft = {
  -- markdown = {'vale',},
  python = {'flake8', 'pylint',},
  sql = {'sqlfluff',},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- local sqlfluff = require('lint').linters.sqlfluff
-- sqlfluff.args = {
--   'lint',
--   '--dialect postgres',
--   -- <- Add a new parameter here
-- }

vim.keymap.set("n", "<M-l>", require("lint").try_lint, { desc = "Lint file" })

