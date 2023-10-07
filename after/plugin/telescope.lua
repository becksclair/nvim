require("telescope").setup({
  -- defaults = {
  --   winblend = 70
  -- }
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  file_ignore_patterns = { "node_modules", "target", ".git" },
  -- mappings = {
  --     n = {
  --         ['<c-d>'] = require('telescope.actions').delete_buffer
  --     }, -- n
  --     i = {
  --         ["<C-h>"] = "which_key",
  --         ['<c-d>'] = require('telescope.actions').delete_buffer
  --     } -- i
  -- }
})


local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>ss', function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
vim.keymap.set('n', '<leader>ss', builtin.live_grep, {})

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sq', require('telescope.builtin').colorscheme, { desc = '[sq] Find color schemes' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
  { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
  { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })


-- vim.keymap.set('n', '<c-d>', require('telescope.actions').delete_buffer)
-- vim.keymap.set('i', '<c-d>', require('telescope.actions').delete_buffer)
--
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
